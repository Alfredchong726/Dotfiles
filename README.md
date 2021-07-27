# Dotfile
### Why using a dotfiles ? 
##### Initially, i am not using the dotfiles to manage my config files, i am using multiply repositories to manage all the config files. But i found that it is very hard to manage all the files. After i repeating git add, git commit, git push for couple of times, i think that i should make a change. But the problem come, i don't really know how to do. I spend some time to do research and summarize something. This also can remind me how i do this.

#### First, have to create one file to store all the configuration file
``` sh
mkdir ~/.dotfiles
```

#### Next, will be mv all your configuration files which you want to upload to your github
#### If you mv config files from .config file, you have to make sure .config file have created in your .dotfiles
``` sh
mv .bashrc ~/.dotfiles/
mv .zshrc ~/.dotfiles/
mv .config/nvim ~/.dotfiles/.config
```

#### After the config files have move into .dotfiles/, all the configuration will lose, so you have to link the file in your home directory to make sure the applications can work
``` sh
ln -sf ~/.dotfiles/bashrc ~/
ln -sf ~/.dotfiles/zshrc ~/
ln -sf ~/.dotfiles/.config/nvim ~/.config/
```

#### If all these done, your config file in your home directory should be like this
<img src="https://raw.githubusercontent.com/Alfredchong260/Dotfiles/main/image/dotfiles.png">

#### After finishing all these our dotfiles almost done
#### Lastly, you need to create a new repository and link with your dotfiles
<img src="https://raw.githubusercontent.com/Alfredchong260/Dotfiles/main/image/github.png">

#### Then you are done with your dotfiles

## A minimal and fast terminal emulator
* [Alacritty](https://github.com/Alfredchong260/Dotfiles/tree/main/.config/alacritty)

## Window manager
### The configuration tutorial is from derek taylor
[Derek Taylor's Youtube channel](https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg)

#### Tiling window manager
* [Qtile](https://github.com/Alfredchong260/Dotfiles/tree/main/.config/qtile)
* [Awesome](https://github.com/Alfredchong260/Dotfiles/tree/main/.config/awesome)

#### Floating window manager
* [Openbox](https://github.com/Alfredchong260/Dotfiles/tree/main/.config/openbox)

## Applications
### Rofi
*[Rofi](https://github.com/Alfredchong260/Dotfiles/tree/main/.config/rofi)

### Neovim
*[Neovim](https://github.com/Alfredchong260/Dotfiles/tree/main/.config/nvim)
