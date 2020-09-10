#!/bin/bash

set -o errexit

SCRIPT_PATH=`dirname "$0"`

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
MAGENTA=$(tput setaf 5)
NC=$(tput sgr0)

function colorize_print {
  local color text
  if [ "$#" -eq 1 ]; then
    color=NC
  fi
  color="$1"
  text="$2"
  case "$color" in
    RED)
      echo "${RED}${text}${NC}"
      ;;
    GREEN)
      echo "${GREEN}${text}${NC}"
      ;;
    YELLOW)
      echo "${YELLOW}${text}${NC}"
      ;;
    MAGENTA)
      echo "${MAGENTA}${text}${NC}"
      ;;
    *)
      echo "${NC}${text}${NC}"
      ;;
  esac
}

# if node isn't installed
if [ ! "$(command -v node)" ]; then
  colorize_print YELLOW "Node.js, which the coc.nvim plugin requires, is not installed"
  read -p "Do you want to install the lastest version of Node.js locally now (y/n)? " install_node

  # install node locally
  if [ "$install_node" = "y" ]; then
    printf "Installing nvm (node version manager) in "
    colorize_print MAGENTA "~/.nvm${NC}..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash &> /dev/null

    . $HOME/.nvm/nvm.sh

    if [ ! "$(command -v nvm)" ]; then
      colorize_print RED "Failed to install nvm... Exiting"
      exit 1
    fi

    colorize_print GREEN "Done"
    echo "Installing Node.js"
    nvm install node

    if [ ! "$(command -v node)" ]; then
      colorize_print RED "Failed to install node... Exiting"
      exit 1
    fi

    colorize_print GREEN "Done"

  # don't install node and exit
  else
    colorize_print YELLOW "Not installing node... Exiting"
    exit 0
  fi

  colorize_print GREEN "Successfully installed Node.js"
fi

echo "Installing vim configs..."
if [ -f ~/.vimrc ]; then
  colorize_print YELLOW "Detected an existing .vimrc file -- making a backup ~/.vimrc.backup"
  mv ~/.vimrc ~/.vimrc.backup
fi
if [ -d ~/.vim ]; then
  colorize_print YELLOW "Detected an existing .vim directory -- making a backup ~/.vim_backup"
  mv ~/.vim ~/.vim_backup
fi
cp .vimrc ~/.vimrc

mkdir -p ~/.vim/swap
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo

echo "Installing plugins..."
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"

echo "Installing extensions for coc.nvim..."
mkdir -p ~/.config/coc/extensions
cp package.json ~/.config/coc/extensions

# if [ ! -x "$(command -v jq)" ]; then
#   echo "${YELLOW}JSON processor \`jq\` not found -- could not parse coc.nvim package list${NC}"
#   echo "${YELLOW}You may need to run ${MAGENTA}:CocUpdateSync${NC} inside vim to install coc extensions"
# fi

colorize_print GREEN "Done"

if [ ! "$(command -v tmux)" ]; then
  colorize_print YELLOW "Tmux not detected... not installing tmux configs"
  return 0
fi

echo "Installing tmux configs..."
if [ -f ~/.tmux.conf ]; then
  colorize_print YELLOW "Detected an existing .tmux.conf file -- making a backup ~/.tmux.conf.backup"
  mv ~/.tmux.conf ~/.tmux.conf.backup
fi
if [ -f ~/.tmux.conf.local ]; then
  colorize_print YELLOW "Detected an existing .tmux.conf.local file -- making a backup ~/.tmux.conf.local.backup"
  mv ~/.tmux.conf.local ~/.tmux.conf.local.backup
fi

cp .tmux.conf ~/.tmux.conf
cp .tmux.conf.local ~/.tmux.conf.local

colorize_print GREEN "Done"
