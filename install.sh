#!/bin/bash

set -o errexit

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
MAGENTA=$(tput setaf 5)
NC=$(tput sgr0)

# if node isn't installed
if [ ! -x "$(command -v node)" ]; then
  echo "${YELLOW}Node.js, which the coc.nvim plugin requres, is not installed${NC}"
  read -p "Do you want to install the lastest version of Node.js locally now (y/n)? " install_node

  # install node locally
  if [ "$install_node" = "y" ]; then
    echo "Installing nvm (node version manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    . ~/.bashrc

    if [ ! -x "$(command -v nvm)" ]; then
      echo "${RED}Failed to install npm... Exiting${NC}"
      exit 1
    fi

    echo "Done"
    echo "Installing Node.js"
    nvm install node

    if [ ! -x "$(command -v node)" ]; then
      echo "${RED}Failed to install node... Exiting${NC}"
      exit 1
    fi

    echo "Done"

  # don't install node and exit
  else
    echo "${YELLOW}Not installing node... Exiting${NC}"
    exit 0
  fi

  echo "${GREEN}Successfully installed Node.js${GREEN}"
fi

echo "Installing vim configs..."
cp .vimrc ~/.vimrc

mkdir ~/.vim/swap
mkdir ~/.vim/backup
mkdir ~/.vim/undo

echo "Installing plugins..."
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"

echo "Installing extensions for coc.nvim..."
mkdir -p ~/.config/coc/extensions
cp package.json ~/.config/coc/extensions

# if [ ! -x "$(command -v jq)" ]; then
#   echo "${YELLOW}JSON processor \`jq\` not found -- could not parse coc.nvim package list${NC}"
#   echo "${YELLOW}You may need to run ${MAGENTA}:CocUpdateSync${NC} inside vim to install coc extensions"
# fi

echo "Done"

if [ -x "$(command -v tmux)" ]; then
  cp .tmux.conf ~/.tmux.conf
  cp .tmux.conf.local ~/.tmux.conf.local
else
  echo "Tmux not detected... not tmux configs"
fi
