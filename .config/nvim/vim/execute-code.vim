augroup exe_code
    autocmd!

    " execute python code
    autocmd FileType python nnoremap <buffer> <leader>r
                \ :vsp<CR>:term python3 %<CR> :startinsert<CR>

    " execute python code
    autocmd FileType javascript nnoremap <buffer> <leader>r
                \ :vsp<CR> :term node %<CR> :startinsert<CR>

    " execute java code
    autocmd FileType java nnoremap <buffer> <leader>r
                \ :vsp<CR>:term java %<CR> :startinsert<CR>

    " execute c language code
    autocmd Filetype c nnoremap <buffer> <leader>r
                \ :vsp<CR>:term gcc %<CR> :startinsert<CR>

    " execute html code
    autocmd Filetype html nnoremap <buffer> <leader>r
                \ :vsp<CR>:term <CR>i

    " execute rust code
    autocmd Filetype rust nnoremap <buffer> <leader>r
                \ :vsp<CR>:term cargo run %<CR> :startinsert <CR>
augroup END
