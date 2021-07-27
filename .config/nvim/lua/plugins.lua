local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute  'packadd packer.nvim'
end

return require('packer').startup(function()

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'hrsh7th/nvim-compe'

    -- Autocomplete COC
    use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}

    -- Formater
    use 'Chiel92/vim-autoformat'

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"windwp/nvim-ts-autotag", opt = true}
    use {'andymass/vim-matchup', opt = true}

    -- Colorscheme
    use 'gruvbox-community/gruvbox'
    use 'liuchengxu/space-vim-dark'
    use 'drewtempelmeyer/palenight.vim'

    -- gc & gcc to coment
    use 'tpope/vim-commentary'

    -- Startify (Customize the menu)
    -- use 'mhinz/vim-startify'
    use 'glepnir/dashboard-nvim'

    -- Airline
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    -- Auto pair for [{(
    use 'jiangmiao/auto-pairs'

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

end)
