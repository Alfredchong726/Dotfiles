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
vim.cmd('source ~/.config/nvim/vim_scripts/default_coc.vim')
vim.cmd('source ~/.config/nvim/vim_scripts/airline.vim')
vim.cmd('source ~/.config/nvim/vim_scripts/telescope.vim')
vim.cmd('source ~/.config/nvim/vim_scripts/vimspector.vim')
vim.cmd('source ~/.config/nvim/vim_scripts/dashboard.vim')
vim.cmd('luafile ~/.config/nvim/lua/colorscheme.lua')

-- require('lv-telescope')
require('lv-treesitter')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

-- Neovide config
vim.cmd("let g:neovide_cursor_vfx_mode = 'railgun'")
vim.cmd("let g:neovide_refresh_rate=140")
vim.cmd("let g:neovide_transparency=0.8")
vim.cmd("let g:neovide_fullscreen=v:true")
vim.cmd("let g:neovide_cursor_animation_length=0.13")
