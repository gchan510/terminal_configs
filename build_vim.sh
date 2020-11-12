#!/bin/bash

DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release)

# Install prereqs
if [[ "$DISTRO" == "ubuntu" ]]; then
  sudo apt install libncurses5-dev libgtk2.0-dev libatk1.0-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev \
    python3-dev ruby-dev lua5.2 liblua5.2-dev libperl-dev git
else
  echo "Running on unknown system: $DISTRO"
  echo "Can't install prerequisites... exiting"
  exit 1
fi

# Clone vim git repo
git clone https://github.com/vim/vim.git

# Build and install vim
cd vim
CFLAGS=$(python3-config --includes) ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --prefix=$HOME/.local

make VIMRUNTIMEDIR=$HOME/.local/share/vim/vim82 -j
make install
