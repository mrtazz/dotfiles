function! GitHubMDTitle()
  let current_line = getline('.')
  " find and replace any short refs to gh issues
  let gh_url = matchstr(current_line, '[/a-zA-Z-_0-9]\+#[0-9]\+')
  if !empty(gh_url)
    let gh_url_parts = split(gh_url, "#")
    if len(gh_url_parts) == 2
      " we use 'issues/' here as it redirects to pulls/discussions
      let issue_url = 'https://github.com/' . gh_url_parts[0] . '/issues/' . gh_url_parts[1]
      let new_url = system('PATH=$PATH:/opt/homebrew/bin gh md link -n ' . issue_url)
      call setline(line('.'), substitute(getline('.'), gh_url, new_url, ''))
      return
    endif
  endif
  " find and replace any long refs to gh issues
  let gh_url = matchstr(current_line, 'https:\/\/github.com\/[a-zA-Z0-9/]\+')
  if !empty(gh_url)
    let new_url = system('PATH=$PATH:/opt/homebrew/bin gh md link -n ' . gh_url)
    call setline(line('.'), substitute(getline('.'), gh_url, new_url, ''))
    return
  endif
endfunction
map <silent> <leader>gt :call GitHubMDTitle()<cr>

function! GitHubCreateIssue(title='')
  if empty(g:GitHubIssuesDefaultRepo)
    echoerr 'Variable g:GitHubIssuesDefaultRepo not set'
    return
  endif
  if a:title == ''
    let current_line = trim(getline('.'))
    let title = trim(matchstr(current_line, '[\@a-zA-Z0-9: ]\+'))
  else
    let title = a:title
  endif
  let new_issue = system('PATH=$PATH:/opt/homebrew/bin gh issue create --repo ' . g:GitHubIssuesDefaultRepo . ' --assignee "@me" --body "" --title "' . title .'"')
  if !empty(new_issue)
    let new_url = system('PATH=$PATH:/opt/homebrew/bin gh md link -n ' . new_issue)
    if a:title == ''
      call setline(line('.'), substitute(getline('.'), title, new_url, ''))
    else
      echom 'Created issue at: ' . new_issue
    endif
  endif
endfunction
map <silent> <leader>gci :call GitHubCreateIssue()<cr>
command! -nargs=? GitHubCreateIssue :call GitHubCreateIssue(<q-args>)

