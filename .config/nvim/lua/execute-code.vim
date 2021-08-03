augroup exe_code
    autocmd!

    " execute python code
    autocmd FileType python nnoremap <buffer> <leader>r
                \ :sp<CR> :term python3 %<CR> :startinsert<CR>

    " execute java code
    autocmd FileType java nnoremap <buffer> <leader>r
                \ :sp<CR> :term java %<CR> :startinsert<CR>

    " execute c language code
    autocmd filetype c nnoremap <buffer> <leader>r
                \ :sp<cr> :term gcc %<cr> :startinsert<cr>

    " execute html code
    autocmd filetype html nnoremap <buffer> <leader>r
                \ :sp<cr> :term firefox %<cr> 
augroup END
