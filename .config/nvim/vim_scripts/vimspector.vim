let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>dl :call vimspector#Launch() <CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutput
autocmd FileType python nmap <leader>dl :CocCommand python.debug.vimspector.start<CR>
