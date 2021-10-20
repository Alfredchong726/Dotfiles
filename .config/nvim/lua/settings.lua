local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
utils.layout_config('b', 'expandtab', true)
utils.layout_config('o', 'smarttab', true)
utils.layout_config('b', 'shiftwidth', indent)
utils.layout_config('b', 'smartindent', true)
utils.layout_config('b', 'autoindent', true)
utils.layout_config('b', 'tabstop', indent)
utils.layout_config('b', 'softtabstop', indent)
utils.layout_config('b', 'shiftwidth', indent)
utils.layout_config('o', 'hidden', true)
utils.layout_config('o', 'scrolloff', 4 )
utils.layout_config('o', 'shiftround', true)
utils.layout_config('o', 'smartcase', true)
utils.layout_config('o', 'ignorecase', true)
utils.layout_config('o', 'wrap', true)
utils.layout_config('o', 'mouse', 'a')
utils.layout_config('o', 'splitbelow', true)
utils.layout_config('o', 'splitright', true)
utils.layout_config('o', 'hlsearch', true)
utils.layout_config('o', 'incsearch', true)
utils.layout_config('o', 'wildmode', 'list:longest')
utils.layout_config('o', 'pumheight', 10)
utils.layout_config('o', 'fileencoding', 'utf-8')
utils.layout_config('o', 'signcolumn', 'yes')
utils.layout_config('o', 'colorcolumn', '80')
utils.layout_config('o', 'cursorline', true)
utils.layout_config('o', 'updatetime', 300)
utils.layout_config('o', 'ruler', true)
utils.layout_config('o', 'showtabline', 2)
utils.layout_config('o', 'termguicolors', true)
utils.layout_config('o', 'scrolloff', 8)
utils.layout_config('w', 'number', true)
utils.layout_config('w', 'relativenumber', true)
utils.layout_config('o', 'clipboard','unnamed,unnamedplus')

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- Python Indent 
vim.cmd 'let g:indentLine_setColors = 0'
vim.cmd "let g:indentLine_char_list = ['|', '¦', '┆', '┊']"

-- Debug
vim.cmd "let g:vimspector_enable_mappings = 'HUMAN'"
vim.cmd "packadd! vimspector"
