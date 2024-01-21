set fish_greeting # No welcome message during enter fish shell
# colorscript random                  # Random colorscript when enter fish shell
set TERM xterm-256color # Set terminal type

set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan


### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Path to Oh My Fish install.
set -q XDG_DATA_HOME
and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

function fish_user_key_bindings
    # fish_default_key_bindings
    fish_vi_key_bindings
end

function Get_Qtile
    sed -n '/START_KEYS/,/END_KEYS/p' ~/.config/qtile/config.py | grep -v '#' | grep Key | sed -e 's/^[ \t]*//'
end

# v function can easily get into file
function f -a change
    set ori_dir (pwd)
    cd $HOME
    set file (fd -Hai . | fzf)

    if test -z $file
        return 1
    end

    set split (string split / $file)
    set chdir "$split[1..-2]"

    if test -z $change
        cd $ori_dir
    else
        set dir (string replace -a ' ' / $chdir)
        cd $dir

        set has_git (fd -Ha . ../ | rg "git\$")
        set len_of_has_git (count $has_git)

        if test $len_of_has_git -eq 1
            cd $has_git
            cd ..
        end
    end
    nvim $file
end

function ll
    ls -lh $argv
end

# run neovim
function vi
    nvim $argv
end

# run neovim in root
function vim
    sudo nvim $argv
end

#run neovide
function vid
    neovide $argv
end

# run neovide in root
function vide
    sudo nvim $argv
end
# update all packages
function update
    sudo pacman -Syyuu --noconfirm
end

# git push in one line of command 
function Git
    git add .
    git commit -m $argv
    git push origin main
end

# straghitly get into init.lua file
function edit
    cd ~/.config/nvim
    nvim init.lua
end

alias activate="source venv/bin/activate.fish"

# change the shell in a easy way
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# git
alias add='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'
alias uncommit='git reset --hard HEAD^'

#iso and version used to install ArcoLinux
alias iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"

# pacman and yay
alias pacsyu='sudo pacman -Syyu' # update only standard pkgs
alias yaysua='yay -Sua --noconfirm' # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm' # update standard pkgs and AUR pkgs (yay)
alias parsua='paru -Sua --noconfirm' # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm' # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck' # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)' # remove orphaned packages

alias cpuname='cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c'
alias cpuinfo='cat /proc/cpuinfo | grep physical | uniq -c'
alias cpubit='getconf LONG_BIT'

alias ,,='cd ..'

#remove
alias rmgitcache="rm -r ~/.cache/git"

#fixes
alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"
alias keyfix="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias key-fix="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias keys-fix="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fixkey="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fixkeys="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-key="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-keys="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-sddm-config="/usr/local/bin/arcolinux-fix-sddm-config"
alias fix-pacman-conf="/usr/local/bin/arcolinux-fix-pacman-conf"
alias fix-pacman-keyserver="/usr/local/bin/arcolinux-fix-pacman-gpg-conf"

# open xampp in shortest way
alias xampp='sudo /opt/lampp/lampp start && cd /opt/lampp && sudo ./manager-linux-x64.run'
# setup the environment
set PATH $PATH /usr/local/bin
set PATH $PATH /usr/bin
set -gx PATH $PATH /usr/local/lib/nodejs/node-v14.17.4-linux-x64/bin/
set -gx PATH $PATH $HOME/.cargo/bin/
set -gx PATH $PATH $HOME/.local/bin/
set -gx PATH $PATH $HOME/.local/share/gem/ruby/3.0.0/bin/
export PATH

set -gx JAVA_HOME /usr/lib/jvm/java-20-openjdk
set -gx CHROME_EXECUTABLE /usr/bin/chromium

starship init fish | source # Start starship
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# to use the autojump
if test -f /home/cms/.autojump/share/autojump/autojump.fish
    . /home/cms/.autojump/share/autojump/autojump.fish
end
