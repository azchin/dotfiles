Aggregation of all my config files and scripts for my Arch Linux desktop.

A lot of configs/scripts use my local path (e.g. for images), so they might not be fully portable.
The main purpose for this repo is to showcase my workflow and applications I utilize on a daily basis.

I'm using a git bare repository, and so all of the directories in here are located in the home directory. 
If the repo is cloned into your home directory, all scripts and configs should run out of the box, with the exception of configurations that depend on computer specific values (e.g. display output identifier)

# Setup
```
mkdir projects
cd projects
git clone --bare git@github.com:$USERNAME/dotfiles.git
alias dots='git --git-dir=$HOME/projects/dotfiles.git --work-tree=$HOME'
dots reset --hard
dots submodule init
dots submodule update
dots config --local status.showUntrackedFiles no
dots config --local pull.ff false # had bad time with ff only
dots config --local pull.rebase true
```

# Vim plug
```
sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -c 'PlugInstall' # FIXME make a plugins only file to load
```

# Alternatives
```
.config/aliases
.config/profile
.config/gtk-3.0/settings.ini
.config/X11/Xresources
```

# PAM
Keyring is `kdewallet`. Look for `libexec/pam_kwallet_init`.

# Zotero
Install browser connector.
Install [zotxt](https://github.com/egh/zotxt).
Sync with account and file sync with WebDAV server.
