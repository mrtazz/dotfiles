function! DatadogInsertImageLink()
  let current_line = getline('.')
  let dd_url = matchstr(current_line, 'https:\/\/app.datadoghq.com\/s\/[a-z0-9-]\+/[a-z0-9-]\+')
  echom "Found dd url: " . dd_url
  if !empty(dd_url)
    let url_list = split(dd_url, "/")
    let dd_img_url = "https://p.datadoghq.com/s/image/" . url_list[-2] . "/" . url_list[-1] . ".png"
    execute "normal! o" . '![](' . dd_img_url . ')'
  endif
endfunction
map <silent> <leader>ddi :call DatadogInsertImageLink()<cr>
