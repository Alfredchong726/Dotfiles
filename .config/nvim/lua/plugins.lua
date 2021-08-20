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

    -- Autocomplete COC
    use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"windwp/nvim-ts-autotag", opt = true}
    use {'andymass/vim-matchup', opt = true}

    -- Colorscheme
    use 'gruvbox-community/gruvbox'
    use 'liuchengxu/space-vim-dark'
    use 'drewtempelmeyer/palenight.vim'
    use 'sonph/onehalf'
    use 'tomasr/molokai'

    -- gc & gcc to coment
    use 'tpope/vim-commentary'

    -- Customize the menu
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

    -- Vim Surround
    use 'tpope/vim-surround'
end)
