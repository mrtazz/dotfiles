package fzf

import (
	"bytes"
	"fmt"
	"regexp"
	"strconv"
	"strings"
	"unicode"

	"github.com/junegunn/fzf/src/util"
)

const rangeEllipsis = 0

// Range represents nth-expression
type Range struct {
	begin int
	end   int
}

func (r Range) IsFull() bool {
	return r.begin == rangeEllipsis && r.end == rangeEllipsis
}

func compareRanges(r1 []Range, r2 []Range) bool {
	if len(r1) != len(r2) {
		return false
	}
	for idx := range r1 {
		if r1[idx] != r2[idx] {
			return false
		}
	}
	return true
}

func RangesToString(ranges []Range) string {
	strs := []string{}
	for _, r := range ranges {
		s := ""
		if r.begin == rangeEllipsis && r.end == rangeEllipsis {
			s = ".."
		} else if r.begin == r.end {
			s = strconv.Itoa(r.begin)
		} else {
			if r.begin != rangeEllipsis {
				s += strconv.Itoa(r.begin)
			}

			if r.begin != -1 {
				s += ".."
				if r.end != rangeEllipsis {
					s += strconv.Itoa(r.end)
				}
			}
		}
		strs = append(strs, s)
	}

	return strings.Join(strs, ",")
}

// Token contains the tokenized part of the strings and its prefix length
type Token struct {
	text         *util.Chars
	prefixLength int32
}

// String returns the string representation of a Token.
func (t Token) String() string {
	return fmt.Sprintf("Token{text: %s, prefixLength: %d}", t.text, t.prefixLength)
}

// Delimiter for tokenizing the input
type Delimiter struct {
	regex *regexp.Regexp
	str   *string
}

// IsAwk returns true if the delimiter is an AWK-style delimiter
func (d Delimiter) IsAwk() bool {
	return d.regex == nil && d.str == nil
}

// String returns the string representation of a Delimiter.
func (d Delimiter) String() string {
	return fmt.Sprintf("Delimiter{regex: %v, str: &%q}", d.regex, *d.str)
}

func newRange(begin int, end int) Range {
	if begin == 1 && end != 1 {
		begin = rangeEllipsis
	}
	if end == -1 {
		end = rangeEllipsis
	}
	return Range{begin, end}
}

// ParseRange parses nth-expression and returns the corresponding Range object
func ParseRange(str *string) (Range, bool) {
	if (*str) == ".." {
		return newRange(rangeEllipsis, rangeEllipsis), true
	} else if strings.HasPrefix(*str, "..") {
		end, err := strconv.Atoi((*str)[2:])
		if err != nil || end == 0 {
			return Range{}, false
		}
		return newRange(rangeEllipsis, end), true
	} else if strings.HasSuffix(*str, "..") {
		begin, err := strconv.Atoi((*str)[:len(*str)-2])
		if err != nil || begin == 0 {
			return Range{}, false
		}
		return newRange(begin, rangeEllipsis), true
	} else if strings.Contains(*str, "..") {
		ns := strings.Split(*str, "..")
		if len(ns) != 2 {
			return Range{}, false
		}
		begin, err1 := strconv.Atoi(ns[0])
		end, err2 := strconv.Atoi(ns[1])
		if err1 != nil || err2 != nil || begin == 0 || end == 0 || begin < 0 && end > 0 {
			return Range{}, false
		}
		return newRange(begin, end), true
	}

	n, err := strconv.Atoi(*str)
	if err != nil || n == 0 {
		return Range{}, false
	}
	return newRange(n, n), true
}

func withPrefixLengths(tokens []string, begin int) []Token {
	ret := make([]Token, len(tokens))

	prefixLength := begin
	for idx := range tokens {
		chars := util.ToChars(stringBytes(tokens[idx]))
		ret[idx] = Token{&chars, int32(prefixLength)}
		prefixLength += chars.Length()
	}
	return ret
}

const (
	awkNil = iota
	awkBlack
	awkWhite
)

func awkTokenizer(input string) ([]string, int) {
	// 9, 32
	ret := []string{}
	prefixLength := 0
	state := awkNil
	begin := 0
	end := 0
	for idx := 0; idx < len(input); idx++ {
		r := input[idx]
		white := r == 9 || r == 32
		switch state {
		case awkNil:
			if white {
				prefixLength++
			} else {
				state, begin, end = awkBlack, idx, idx+1
			}
		case awkBlack:
			end = idx + 1
			if white {
				state = awkWhite
			}
		case awkWhite:
			if white {
				end = idx + 1
			} else {
				ret = append(ret, input[begin:end])
				state, begin, end = awkBlack, idx, idx+1
			}
		}
	}
	if begin < end {
		ret = append(ret, input[begin:end])
	}
	return ret, prefixLength
}

// Tokenize tokenizes the given string with the delimiter
func Tokenize(text string, delimiter Delimiter) []Token {
	if delimiter.str == nil && delimiter.regex == nil {
		// AWK-style (\S+\s*)
		tokens, prefixLength := awkTokenizer(text)
		return withPrefixLengths(tokens, prefixLength)
	}

	if delimiter.str != nil {
		return withPrefixLengths(strings.SplitAfter(text, *delimiter.str), 0)
	}

	// FIXME performance
	var tokens []string
	if delimiter.regex != nil {
		locs := delimiter.regex.FindAllStringIndex(text, -1)
		begin := 0
		for _, loc := range locs {
			tokens = append(tokens, text[begin:loc[1]])
			begin = loc[1]
		}
		if begin < len(text) {
			tokens = append(tokens, text[begin:])
		}
	}
	return withPrefixLengths(tokens, 0)
}

// StripLastDelimiter removes the trailing delimiter and whitespaces
func StripLastDelimiter(str string, delimiter Delimiter) string {
	if delimiter.str != nil {
		str = strings.TrimSuffix(str, *delimiter.str)
	} else if delimiter.regex != nil {
		locs := delimiter.regex.FindAllStringIndex(str, -1)
		if len(locs) > 0 {
			lastLoc := locs[len(locs)-1]
			if lastLoc[1] == len(str) {
				str = str[:lastLoc[0]]
			}
		}
	}
	return strings.TrimRightFunc(str, unicode.IsSpace)
}

// JoinTokens concatenates the tokens into a single string
func JoinTokens(tokens []Token) string {
	var output bytes.Buffer
	for _, token := range tokens {
		output.WriteString(token.text.ToString())
	}
	return output.String()
}

// Transform is used to transform the input when --with-nth option is given
func Transform(tokens []Token, withNth []Range) []Token {
	transTokens := make([]Token, len(withNth))
	numTokens := len(tokens)
	for idx, r := range withNth {
		parts := []*util.Chars{}
		minIdx := 0
		if r.begin == r.end {
			idx := r.begin
			if idx == rangeEllipsis {
				chars := util.ToChars(stringBytes(JoinTokens(tokens)))
				parts = append(parts, &chars)
			} else {
				if idx < 0 {
					idx += numTokens + 1
				}
				if idx >= 1 && idx <= numTokens {
					minIdx = idx - 1
					parts = append(parts, tokens[idx-1].text)
				}
			}
		} else {
			var begin, end int
			if r.begin == rangeEllipsis { // ..N
				begin, end = 1, r.end
				if end < 0 {
					end += numTokens + 1
				}
			} else if r.end == rangeEllipsis { // N..
				begin, end = r.begin, numTokens
				if begin < 0 {
					begin += numTokens + 1
				}
			} else {
				begin, end = r.begin, r.end
				if begin < 0 {
					begin += numTokens + 1
				}
				if end < 0 {
					end += numTokens + 1
				}
			}
			minIdx = util.Max(0, begin-1)
			for idx := begin; idx <= end; idx++ {
				if idx >= 1 && idx <= numTokens {
					parts = append(parts, tokens[idx-1].text)
				}
			}
		}
		// Merge multiple parts
		var merged util.Chars
		switch len(parts) {
		case 0:
			merged = util.ToChars([]byte{})
		case 1:
			merged = *parts[0]
		default:
			var output bytes.Buffer
			for _, part := range parts {
				output.WriteString(part.ToString())
			}
			merged = util.ToChars(output.Bytes())
		}

		var prefixLength int32
		if minIdx < numTokens {
			prefixLength = tokens[minIdx].prefixLength
		} else {
			prefixLength = 0
		}
		transTokens[idx] = Token{&merged, prefixLength}
	}
	return transTokens
}
