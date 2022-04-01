# NeoVim configuration by lua and vim scripts
###### This nvim config can also used for NeoVide which contain a better view experience

### Before start you need to make sure your nvim at least is 0.5.0 if not you may not use some features of this config file. Moreover, thee may occur some errors.

#### Before clone the whole nvim config file into home directory you need to make sure you have vim-packer installed for managing all the vim plugins
[vim-packer](https://github.com/hashivim/vim-packer)

#### After installed the vim-packer, can start to clone the whole nvim file into home directory

#### Next, you need to run this command to make sure all the file has save and source
``` sh
:w | luafile %
```

#### After source the file you can start to install all the plugins by using this command
```sh
:PackerInstall
```

#### All these steps finished then your NeoVim can work well
<img src='https://github.com/Alfredchong260/Dotfiles/blob/main/image/nvim.png'>

##### Here is some usage of the NeoVim

##### You can straightly type nvim on your terminal, then this may show
###### You can follow the command show on your screen
   Command    | What will do ?
------------- | ------------- 
      f       | Find a file by the filename
      e       | Create a new file
      p       | Find project
      r       | View the recent files
      t       | Find a file by text
      c       | Go to nvim config file
      q       | Quit NeoVim

#### If you want to edit this page you can go to /home/username/.config/nvim/lua/user/alpha.lua to modify
###### This function is powered by telescope you can type jk to exit insert mode
   Command    | What will do ?                              |
------------- | -------------                               |
  Alt-j       | move current line down                      |
  Alt-k       | move current line up                        |
  Space w     | Write file                                  |
  Space q     | Quit the file without saving                |
  Shift t     | Calling for terminal                        |
  Shift b     | Debug for only python file                  |
  Shift l or h| Qucik move between next and previous buffer |
  jk          | To exit insert mode in fastest way          |

#### You can also straightly hit the space key to view others instruction which powered by [vim-which-key](https://github.com/liuchengxu/vim-which-key)

#### I am using coc.nvim as my completion it support a lot of programming language completion, you can use this command to install the coc extensions (I am not using coc.nvim anymore, instead of coc.nvim, i am using LSP, if you are interested to use LSP instead of coc.nvim you can try this [video](https://www.youtube.com/watch?v=6F3ONwrCxMg&t=757s))
#### The troubleshot and the helps of coc.nvim will leave it here for helping
```sh
:CocInstall coc-json coc-spell-checker
```
#### If you want others coc extensions or you worth others coc functions you can go to coc extensions to download others extensions

[coc extensions](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)

## Troubleshot
### Some troubles you might face during using the coc completion
##### "node" is not executable
##### build/index.js not found, please compile coc.nvim ny npm run build
```sh
-- Solution of first scenario 
-- Go to nodejs.org and install node.js file

// run these command on your terminal to setup the environment for nodejs
cd /usr/local/lib/
mkdir -p nodejs

cd ~/Downloads
sudo tar -xJvf node-v14.15.4-linux-x64.tar.xz /usr/local/lib/nodejs/

// Then this step will be different, it depends on what shell you are using

// Bash
// In your .bashrc add this line
export PATH=cd /usr/local/lib/nodejs/node-v14.17.4-linux-x64/bin:$PATH

// Fish
// In your ~/.config/fish/config.fish add this line
set -gx PATH $PATH /usr/local/lib/nodejs/node-v14.17.4-linux-x64/bin/

// Then  you can check the path by using this command
echo $PATH
```
###### Then you can see this 
<img src='https://github.com/Alfredchong260/Dotfiles/blob/main/image/example.png'>

```sh
// Solution of second scenario 
// run this command on your terminal then it will fix

npm install coc.nvim@0.0.81-next.5 
```

### To code with java you have to setup java environment
### First, check your java version
```sh
java --version
```

#### If it appear the java version then that is fine, but if there show java is unknown command, you have to install jkd

###### For Arch Linux 
```sh
sudo pacman -S jre-openjdk jdk-openjdk
```

###### For Ubuntu
```sh
sudo apt-get install openjdk-8-jre openjdk-8-jdk
```
