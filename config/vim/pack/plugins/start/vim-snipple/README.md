# vim-snipple


## Overview
I wanted to manage some snippets but all the snippet management plugins
provided too many options and features. I have very pedestrian needs, so I
just wanted to do 2 things:

1. List all available snippets
2. Load the selected snippet into the current buffer

It deliberately doesn't do any expansion of things or support variables or
anything like that.

## Usage

`:SnippleLoad <TAB>`


## Configuration

- `g:SnippleBaseDir`: Location of your snippets, defaults to `~/.snippets`


Example snippets directory:

```
~/.snippets
├── go
│   └── test.snippet
└── ruby
    └── test.snippet
```

