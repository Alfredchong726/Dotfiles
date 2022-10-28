require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.toggleterm"
require "user.project"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
require "user.lualine"
require "user.bufferline"

vim.cmd('source ~/.config/nvim/vim/execute-code.vim')

-- vscode and nvim only settings
if (vim.g.vscode) then
    -- VSCode extension
else
    -- ordinary neovim
end
