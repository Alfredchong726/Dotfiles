-- .___         .__   __   .__                   
-- |   |  ____  |__|_/  |_ |  |   __ __ _____    
-- |   | /    \ |  |\   __\|  |  |  |  \\__  \   
-- |   ||   |  \|  | |  |  |  |__|  |  / / __ \_ 
-- |___||___|  /|__| |__|/\|____/|____/ (____  / 
--           \/          \/                  \/  

require('lv-global')
vim.cmd('luafile '..CONFIG_PATH..'/lv-setting.lua')
require('plugins')
require('keymaps')
require('settings')

vim.cmd('source ~/.config/nvim/lua/execute-code.vim')
vim.cmd('source ~/.config/nvim/plugin/default_coc.vim')
vim.cmd('source ~/.config/nvim/plugin/airline.vim')
vim.cmd('source ~/.config/nvim/plugin/telescope.vim')
vim.cmd('luafile ~/.config/nvim/plugin/colorscheme.lua')

require('lv-telescope')
require('lv-treesitter')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

