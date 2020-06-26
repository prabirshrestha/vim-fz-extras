function! fz#extras#filetype#run() abort
  call fz#run({
    \ 'type': 'list',
    \ 'list': uniq(map(split(globpath(&rtp, "syntax/*.vim"), "\n"), "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')")),
    \ 'accept': function('s:accept'),
    \ })
endfunction

function! s:accept(result) abort
  exec 'setfiletype ' . a:result['items'][0]
endfunction
