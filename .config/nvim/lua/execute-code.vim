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

    autocmd filetype c nnoremap <buffer> <leader>r
                \ :sp<cr> :term gcc %<cr> :startinsert<cr>
augroup END
