#!/bin/bash

TEMP=`getopt -o h --long help,extra-features -n 'install.sh' -- "$@"`
eval set -- "${TEMP}"

function print_help {
  printf "Usage: clean.sh [-h|--help] [--extra-features]\n"
  printf "\t-h|--help\t\tPrint out this help message\n"
  printf "\t---extra-features\tInstall some experimental extra features\n"
}

INSTALL_EXTRA=false
while true; do
  case "$1" in
    -h | --help )
      print_help; exit 0 ;;
    --extra-features )
      INSTALL_EXTRA=true ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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
    exit 1
  fi

  colorize_print GREEN "Successfully installed Node.js"
fi

if [ ! -d $HOME/.fzf ]; then
  colorize_print YELLOW "fzf not detected on system -- installing now..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  colorize_print GREEN "Done"
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
mkdir -p ~/.vim/syntax
cp llvm.vim ~/.vim/syntax

echo "Installing plugins..."
vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
vim -es -u ~/.vimrc -i NONE -c "PlugUpgrade" -c "qa"
vim -es -u ~/.vimrc -i NONE -c "PlugUpdate" -c "qa"
colorize_print GREEN "Done"

echo "Installing extensions for coc.nvim..."
coc_extensions='coc-clangd coc-cmake coc-fzf-preview coc-json coc-python coc-sh coc-todolist'
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
    echo '{"dependencies":{}}'> package.json
fi
npm install ${coc_extensions} --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
cd ${SCRIPT_PATH}

colorize_print GREEN "Done"

if [ ! "$(command -v tmux)" ]; then
  colorize_print YELLOW "Tmux not detected... not installing tmux configs"
  exit 1
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
colorize_print YELLOW "Source your .bashrc to enable Node.js (required by coc.nvim)"

# Install bash stuff
retval=$(./get_exe.sh)

if [ ! "$?" ]; then
  colorize_print RED "${retval}"
  exit 1
fi
