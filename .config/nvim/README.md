# NeoVim configuration by lua and vim scripts

### Before start you need to make sure your nvim at least is 0.5.0 if not you may not use some features of this config file. Moreover, thee may occur some errors.

#### Before clone the whole nvim config file into home directory you need to make sure you have vim-packer installed for managing all the vim plugins
[vim-packer](https://github.com/hashivim/vim-packer)

#### After installed tje vim-packer, can start to clone the whole nvim file into home directory

#### Next, you need to run this command to make sure all the file has save and source
``` sh
:w | luafile%
```

#### After source the file you can start to install all the plugins by using this command
```sh
:PackerInstall
```

#### All these steps finished then your NeoVim can work well
<img src='https://github.com/Alfredchong260/Dotfiles/blob/main/image/nvim.png'>
##### Here is some usage of the NeoVim

###### You can straightly type nvim on your terminal, then this may show
###### You can follow the command show on your screen
   Command    | What will do ?
------------- | ------------- 
  Space f f   | Find a file by the filename
  Space f g   | Find a file by the content of the file
  Space f h   | Find a file you recent opened
  Space t c   | Change current colorscheme

#### If you want to edit this page you can go to .config/nvim/plugin/dashboard.vim to modify
###### This function is powered by telescope you can type jj, kk, jk to exit insert mode
   Command    | What will do ?                    | Represent
------------- | -------------                     | -------------
  Space       | Set no highlight find             |(:set hlsearch!)
  Space w     | Write file                        |(:w)
  Space w q   | Write and quit the file           |(:wq)
  Space q     | Quit the file without saving      |(:q)
  Space w a s | Write and source the config file  |(:w | luafile%)
  Space y y   | Copy the whole line               |
  Space b d   | Add a new buffer                  |(:bd)
  Space d d   | Detele current buffer             |(:badd)
  Space h     | Go to first buffer                |(:bfirst)
  Space l     | Go to last buffer                 |(:blast)
  Space n     | Go to next buffer                 |(:bnext)
  Space b     | Go to previous buffer             |(:bprevious)
  jj kk jk    | To exit insert mode in fastest way|

#### I am using coc-vim as my completion it support a lot of programming language completion, you can use this command to install the coc extensions
```sh
:CocInstall coc-json coc-spell-checker
```
#### If you want others coc extensions or you worth others coc functions you can go to coc extensions to download others extensions
[coc extensions](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)
