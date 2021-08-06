augroup exe_code
    autocmd!

    " execute python code
    autocmd FileType python nnoremap <buffer> <leader>r
                \ :sp<CR> :resize10<CR> :term python3 %<CR> :startinsert<CR>

    " execute java code
    autocmd FileType java nnoremap <buffer> <leader>r
                \ :sp<CR> :sp<CR> :resize10<CR>:term java %<CR> :startinsert<CR>

    " execute c language code
    autocmd filetype c nnoremap <buffer> <leader>r
                \ :sp<CR> :sp<CR> :resize10<CR>:term gcc %<CR> :startinsert<CR>

    " execute html code
    autocmd filetype html nnoremap <buffer> <leader>r
                \ :sp<CR> :sp<CR> :resize10<CR>:term firefox %<CR> 
augroup END
