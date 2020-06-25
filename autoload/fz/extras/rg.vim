function! fz#extras#rg#run(opt) abort
  let l:basepath = expand('.')

  call fz#run({
      \ 'type': 'cmd',
      \ 'cmd': 'rg --column --line-number --no-heading --color=auto '.shellescape(a:opt['searchterm']),
      \ 'accept': function('s:accept', [l:basepath])
      \ })
endfunction

function! s:accept(basepath, result) abort
  let l:items = a:result['items']
  let l:path = expand(l:items[0])
  let l:parts = matchlist(l:path, '\(.\{-}\):\(\d\+\)\%(:\(\d\+\)\)\?\%(:\(.*\)\)\?')
  let l:path = &acd ? fnamemodify(l:parts[1], ':p') : l:parts[1]
  let l:path = expand(l:path)
  let l:lnum = l:parts[2]
  let l:col = l:parts[3]

  if !s:absolute_path(l:path)
    let l:path = a:basepath . '/' . l:path
  endif

  if filereadable(expand(l:path))
    if &modified
      if winwidth(win_getid()) > winheight(win_getid()) * 3
        exe 'vsplit' l:path
      else
        exe 'split' l:path
      endif
    else
      exe 'edit' l:path
    endif
    if exists('l:lnum') | execute l:lnum | endif
    if exists('l:col') | execute 'normal!' l:col . '|' | endif
    if exists('l:lnum') || exists('l:col')
      normal! zz
    endif
  else
    echom "not readable file " . expand(l:path)
  endif
endfunction

function! s:absolute_path(path) abort
  if has('win32')
    return a:path =~# '^\([/\\]\|[a-zA-Z]:[/\\]\)'
  endif
  return a:path =~# '^/'
endfunction
