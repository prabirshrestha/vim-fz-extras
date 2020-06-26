if exists('g:vim_fz_extras')
    finish
endif
let g:vim_fz_extras = 1

command! -bang -nargs=* FzRg call fz#extras#rg#run({'searchterm':<q-args>})
nnoremap <Plug>(fz-extras-rg) :<c-u>FzRg 

command! -bang -nargs=* FzColorscheme call fz#extras#colorscheme#run()
nnoremap <Plug>(fz-extras-colorscheme) :<c-u>FzColorscheme<CR>

command! -bang -nargs=* FzFiletype call fz#extras#filetype#run()
nnoremap <Plug>(fz-extras-filetype) :<c-u>FzFiletype<CR>
