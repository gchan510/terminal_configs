#!/bin/bash

set -o nounset
set -o errexit

# if node isn't installed
if [ ! -x "$(command -v node)" ]; then
  echo "Node.js, which the coq.nvim plugin requres, is not installed"
  read -p "Do you want to install the lastest version of Node.js locally now (y/n)? " install_node

  # install node locally
  if [ "$install_node" -eq "y" ]; then
    echo "Installing nvm (node version manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    source ~/.bashrc

    if [ ! -x "$(command -v nvm)" ]; then
      "Failed to install npm... Exiting"
      exit 1
    fi

    echo "Done"
    echo "Installing Node.js"
    nvm install node

    if [ ! -x "$(command -v node)" ]; then
      echo "Failed to install node... Exiting"
      exit 1
    fi

    echo "Done"

  # don't install node and exit
  else
    "Not installing node... Exiting"
    exit 0
  fi

  echo "Successfully installed Node.js"
fi

echo "Installing vim configs..."
cp .vimrc ~/.vimrc

mkdir ~/.vim/swap
mkdir ~/.vim/backup
mkdir ~/.vim/undo

echo "Installing plugins..."
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"

echo "Done"

if [ -x "$(command -v tmux)" ]; then
  cp .tmux.conf ~/.tmux.conf
  cp .tmux.conf.local ~/.tmux.conf.local
else
  echo "Tmux not detected... not tmux configs"
fi
