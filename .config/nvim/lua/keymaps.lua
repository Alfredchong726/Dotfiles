local utils = require('utils')

vim.g.mapleader = ' '

-- Clear highlights
utils.map('n', '<Leader>', ':set hlsearch!<CR>')

-- Autoformat
utils.map('n', '<F3>', ':Autoformat<CR>')

-- Window move
utils.map('n', '<C-h>', '<C-w>h')
utils.map('n', '<C-j>', '<C-w>j')
utils.map('n', '<C-k>', '<c-w>k')
utils.map('n', '<C-l>', '<c-w>l')

-- Indenting
utils.map('v', '<S-TAB>', '<gv')
utils.map('v', '<TAB>', '>gv')

-- Buffer movement
utils.map('n', '<Leader>b', ':bprevious<CR>')
utils.map('n', '<Leader>n', ':bnext<CR>')
utils.map('n', '<Leader>h', ':bfirst<CR>')
utils.map('n', '<Leader>l', ':blast<CR>')

-- Add a buffer
utils.map('n', '<Leader>ba', ':badd')

-- Delete current buffer
utils.map('n', '<Leader>dd', ':bd<CR>')

-- Use for easy escape
utils.map('i', 'jj', '<Esc>')           -- jj to escape
utils.map('i', 'kk', '<Esc>')           -- kk to escape
utils.map('i', 'jk', '<Esc>')           -- jk to escape

-- Write the file
utils.map('n', '<Leader>w', ':w<CR>')

-- Close file
utils.map('n', '<Leader>q', ':q<CR>')

-- Write and Close the file
utils.map('n', '<Leader>wq', ':wq<CR>')

-- Write and source the file
utils.map('n', '<Leader>was', ':w | luafile %<CR>')

-- Move selected line
utils.map('x', 'K', ':move \'<-2<CR>gv-gv\'')
utils.map('x', 'J', ':move \'>+1<CR>gv-gv\'')

-- Space ts for calling terminal
utils.map('n', '<Leader>ts', ':bel split term://fish<CR>:resize 10<CR>i')

-- Call Startify
utils.map('n', '<Leader>S', ':Startify<CR>')
