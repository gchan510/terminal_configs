#!/bin/bash

to_remove=""

if [ -f ~/.vimrc ]; then
  to_remove="${to_remove} ${HOME}/.vimrc"
fi
if [ -d ~/.vim ]; then
  to_remove="${to_remove} ${HOME}/.vim"
fi
if [ -f ~/.tmux.conf ]; then
  to_remove="${to_remove} ${HOME}/.tmux.conf"
fi
if [ -f ~/.tmux.conf.local ]; then
  to_remove="${to_remove} ${HOME}/.tmux.conf.local"
fi
if [ -d ~/.nvm ]; then
  to_remove="${to_remove} ${HOME}/.nvm"
fi
if [ -d ~/.npm ]; then
  to_remove="${to_remove} ${HOME}/.npm"
fi
if [ -d ~/.config/coc ]; then
  to_remove="${to_remove} ${HOME}/.config/coc"
fi

printf "The following directories will be deleted:\n"
printf "\t${to_remove}\n"
read -p "Confirm that you would like to delete these files/directories (y/n)? " remove_files

if [ "$remove_files" = "y" ]; then
  for x in ${to_remove}; do
    rm -rf $x
  done
else
  echo "Exiting -- no files were deleted"
fi

