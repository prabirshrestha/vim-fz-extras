function! fz#extras#colorscheme#run() abort
  call fz#run({
    \ 'type': 'list',
    \ 'list': uniq(map(split(globpath(&rtp, "colors/*.vim"), "\n"), "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')")),
    \ 'accept': function('s:accept'),
    \ })
endfunction

function! s:accept(result) abort
  exec 'colorscheme ' . a:result['items'][0]
endfunction
