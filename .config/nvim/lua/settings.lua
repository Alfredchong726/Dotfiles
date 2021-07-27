local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
utils.opt('b', 'expandtab', true)
utils.opt('o', 'smarttab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'autoindent', true)
utils.opt('b', 'tabstop', indent)
utils.opt('b', 'softtabstop', indent)
utils.opt('b', 'shiftwidth', indent)
utils.opt('o', 'hidden', true)
utils.opt('o', 'scrolloff', 4 )
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'wrap', true)
utils.opt('o', 'mouse', 'a')
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'hlsearch', true)
utils.opt('o', 'incsearch', true)
utils.opt('o', 'wildmode', 'list:longest')
utils.opt('o', 'pumheight', 10)
utils.opt('o', 'fileencoding', 'utf-8')
utils.opt('o', 'signcolumn', 'yes')
utils.opt('o', 'colorcolumn', '80')
utils.opt('o', 'cursorline', true)
utils.opt('o', 'updatetime', 300)
utils.opt('o', 'ruler', true)
utils.opt('o', 'showtabline', 2)
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'scrolloff', 8)
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('o', 'clipboard','unnamed,unnamedplus')

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
