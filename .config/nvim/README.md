# NeoVim configuration by lua and vim scripts

### Before clone the whole nvim config file into home direcoty you need to make sure you have vim-packer installed for managing all the vim plugins
[vim-packer](https://github.com/hashivim/vim-packer)

### After installed tje vim-packer, can start to clone the whole nvim file into home directory

### Next, you need to run this command to make sure all the file has save and source
``` sh
:w | luafile%
```

### After source the file you can start to install all the plugins by using this command
```sh
:PackerInstall
```

### All these steps finished then your NeoVim can work well

#### Here is some usage of the NeoVim

###### You can straightly type nvim on your terminal, then this may show
###### You can follow the command show on your screen
   Command    | What will do ?
------------- | ------------- 
  Space f f   | Find a file by the filename
  Space f g   | Find a file by the content of the file
  Space f h   | Find a file you recent opened
  Space t c   | Change current colorscheme

#### If you want to edit this page you can go to .config/nvim/plugin/dashboard.vim to modify
