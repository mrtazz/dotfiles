function! GitHubMDTitle()
  let current_line = getline('.')
  let gh_url = matchstr(current_line, 'https:\/\/github.com\/[a-zA-Z0-9/_#-]\+')
  if !empty(gh_url)
    let new_url = system('PATH=$PATH:/opt/homebrew/bin gh md link -n ' . gh_url)
    call setline(line('.'), substitute(getline('.'), gh_url, new_url, ''))
  endif
endfunction
map <silent> <leader>gt :call GitHubMDTitle()<cr>


function! GitHubCreateIssue()
  if empty(g:GitHubIssuesDefaultRepo)
    echoerr 'Variable g:GitHubIssuesDefaultRepo not set'
    return
  endif
  let current_line = trim(getline('.'))
  let title = trim(matchstr(current_line, '[\@a-zA-Z0-9 ]\+'))
  let new_issue = system('PATH=$PATH:/opt/homebrew/bin gh issue create --repo ' . g:GitHubIssuesDefaultRepo . ' --assignee "@me" --body "" --title "' . title .'"')
  if !empty(new_issue)
    let new_url = system('PATH=$PATH:/opt/homebrew/bin gh md link -n ' . new_issue)
    call setline(line('.'), substitute(getline('.'), title, new_url, ''))
  endif
endfunction
map <silent> <leader>gci :call GitHubCreateIssue()<cr>
