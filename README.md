# Configs for vim and tmux

## Installing vim config
Either run `install.sh` (experimental) or manually run the commands below

Copy `.vimrc` to your home directory.
To install plugins, first install the `vim-plug` plugin manager with
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then in vim use `:PlugInstall` to download plugins.

Create `swap`, `backup`, and `undo` directories in `~/.vim` to store
swap, backup, and undo files that vim uses.

## Installing tmux config
Copy `.tmux.conf` and `.tmux.conf.local` to your home directory.
