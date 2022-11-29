-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- TODO: adding some additional keymaps
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Insert
keymap("i", "jk", "<ESC>", opts)

-- Visual
keymap("v", "<S-TAB>", "<gv", opts)
keymap("v", "<TAB>", ">gv", opts)

-- Visual Block
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

vim.api.nvim_exec(
  [[
augroup exe_code
  autocmd!
  " execute python code
  autocmd FileType python nnoremap <buffer> <leader>r
            \ :vsp<CR>:term python3 %<CR> :startinsert<CR>
  " execute javascript code
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
            \ :vsp<CR>:term chromium %<CR>i
  " execute rust code
  autocmd Filetype rust nnoremap <buffer> <leader>r
            \ :vsp<CR>:term cargo run %<CR> :startinsert <CR>
  " execute golang code
  autocmd Filetype go nnoremap <buffer> <leader>r
            \ :sp<CR>:term go run %<CR> :startinsert <CR>
augroup END
]],
  true
)
