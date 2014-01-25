if exists("g:loaded_syntastic_loclist")
    finish
endif
let g:loaded_syntastic_loclist = 1

let g:SyntasticLoclist = {}

" Public methods {{{1

function! g:SyntasticLoclist.New(rawLoclist)
    let newObj = copy(self)

    let llist = filter(copy(a:rawLoclist), 'v:val["valid"] == 1')

    for e in llist
        if empty(e['type'])
            let e['type'] = 'E'
        endif
    endfor

    let newObj._rawLoclist = llist
    let newObj._name = ''

    return newObj
endfunction

function! g:SyntasticLoclist.current()
    if !exists("b:syntastic_loclist")
        let b:syntastic_loclist = g:SyntasticLoclist.New([])
    endif
    return b:syntastic_loclist
endfunction

function! g:SyntasticLoclist.extend(other)
    let list = self.copyRaw()
    call extend(list, a:other.copyRaw())
    return g:SyntasticLoclist.New(list)
endfunction

function! g:SyntasticLoclist.isEmpty()
    return empty(self._rawLoclist)
endfunction

function! g:SyntasticLoclist.copyRaw()
    return copy(self._rawLoclist)
endfunction

function! g:SyntasticLoclist.getRaw()
    return self._rawLoclist
endfunction

function! g:SyntasticLoclist.getLength()
    return len(self._rawLoclist)
endfunction

function! g:SyntasticLoclist.getName()
    return len(self._name)
endfunction

function! g:SyntasticLoclist.setName(name)
    let self._name = a:name
endfunction

function! g:SyntasticLoclist.decorate(name, filetype)
    for e in self._rawLoclist
        let e['text'] .= ' [' . a:filetype . '/' . a:name . ']'
    endfor
endfunction

function! g:SyntasticLoclist.quietMessages(filters)
    call syntastic#util#dictFilter(self._rawLoclist, a:filters)
endfunction

function! g:SyntasticLoclist.errors()
    if !exists("self._cachedErrors")
        let self._cachedErrors = self.filter({'type': "E"})
    endif
    return self._cachedErrors
endfunction

function! g:SyntasticLoclist.warnings()
    if !exists("self._cachedWarnings")
        let self._cachedWarnings = self.filter({'type': "W"})
    endif
    return self._cachedWarnings
endfunction

" Legacy function.  Syntastic no longer calls it, but we keep it
" around because other plugins (f.i. powerline) depend on it.
function! g:SyntasticLoclist.hasErrorsOrWarningsToDisplay()
    return !self.isEmpty()
endfunction

" cache used by EchoCurrentError()
function! g:SyntasticLoclist.messages(buf)
    if !exists("self._cachedMessages")
        let self._cachedMessages = {}
        let errors = self.errors() + self.warnings()

        for e in errors
            let b = e['bufnr']
            let l = e['lnum']

            if !has_key(self._cachedMessages, b)
                let self._cachedMessages[b] = {}
            endif

            if !has_key(self._cachedMessages[b], l)
                let self._cachedMessages[b][l] = e['text']
            endif
        endfor
    endif

    return get(self._cachedMessages, a:buf, {})
endfunction

"Filter the list and return new native loclist
"e.g.
"  .filter({'bufnr': 10, 'type': 'e'})
"
"would return all errors for buffer 10.
"
"Note that all comparisons are done with ==?
function! g:SyntasticLoclist.filter(filters)
    let conditions = values(map(copy(a:filters), 's:translate(v:key, v:val)'))
    let filter = len(conditions) == 1 ?
        \ conditions[0] : join(map(conditions, '"(" . v:val . ")"'), ' && ')
    return filter(copy(self._rawLoclist), filter)
endfunction

function! g:SyntasticLoclist.setloclist()
    if !exists('w:syntastic_loclist_set')
        let w:syntastic_loclist_set = 0
    endif
    let replace = g:syntastic_reuse_loc_lists && w:syntastic_loclist_set
    call syntastic#log#debug(g:SyntasticDebugNotifications, 'loclist: setloclist ' . (replace ? '(replace)' : '(new)'))
    call setloclist(0, self.getRaw(), replace ? 'r' : ' ')
    let w:syntastic_loclist_set = 1
endfunction

"display the cached errors for this buf in the location list
function! g:SyntasticLoclist.show()
    call syntastic#log#debug(g:SyntasticDebugNotifications, 'loclist: show')
    call self.setloclist()

    if !self.isEmpty()
        let num = winnr()
        execute "lopen " . g:syntastic_loc_list_height
        if num != winnr()
            wincmd p
        endif

        " try to find the loclist window and set w:quickfix_title
        let errors = getloclist(0)
        for buf in tabpagebuflist()
            if buflisted(buf) && bufloaded(buf) && getbufvar(buf, '&buftype') ==# 'quickfix'
                let win = bufwinnr(buf)
                let title = getwinvar(win, 'quickfix_title')

                " TODO: try to make sure we actually own this window; sadly,
                " errors == getloclist(0) is the only somewhat safe way to
                " achieve that
                if strpart(title, 0, 16) ==# ':SyntasticCheck ' ||
                            \ ( (title == '' || title ==# ':setloclist()') && errors == getloclist(0) )
                    call setwinvar(win, 'quickfix_title', ':SyntasticCheck ' . self._name)
                endif
            endif
        endfor
    endif
endfunction

" Non-method functions {{{1

function! g:SyntasticLoclistHide()
    call syntastic#log#debug(g:SyntasticDebugNotifications, 'loclist: hide')
    silent! lclose
endfunction

" Private functions {{{1

function! s:translate(key, val)
    return 'get(v:val, ' . string(a:key) . ', "") ==? ' . string(a:val)
endfunction

" vim: set sw=4 sts=4 et fdm=marker:
