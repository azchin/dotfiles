#!/bin/sh
set -eu

REPO=$(git remote -v | head -n1 | awk '{ print  $2 }')
PROJ=$HOME/projects

mkdir -p $HOME/clone
mkdir -p $HOME/sandbox
mkdir -p $HOME/.cache
mkdir -p $HOME/.local
mkdir -p $HOME/.config
mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh
mkdir -p $PROJ
cd $PROJ

git clone --bare --recurse-submodules $REPO 
alias dots='git --git-dir=$HOME/projects/dotfiles.git --work-tree=$HOME'
dots reset --hard
dots config --local status.showUntrackedFiles no
dots submodule init
dots submodule update

mkdir -p $HOME/.local/share/nvim
sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -c 'PlugInstall'

echo "Symlinking stuff: what's the name of your system?"
read HOST
ln -s "$HOME/.config/aliases-$HOST" $HOME/.config/aliases
ln -s "$HOME/.config/profile-$HOST" $HOME/.config/profile
ln -s "$HOME/.config/gtk-3.0/settings-$HOST.ini" $HOME/.config/gtk-3.0/settings.ini
ln -s "$HOME/.config/X11/Xresources-$HOST" $HOME/.config/X11/Xresources
ln -s $HOME/Nextcloud $HOME/drive
ln -s $HOME/drive/org $HOME/org
ln -s $HOME/drive/org-roam $HOME/org-roam
