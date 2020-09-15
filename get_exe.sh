#!/bin/bash

if [ ! $(command -v gem) ]; then
  echo "Some components require RubyGem to be installed! Exiting..."
  return 1
fi

mkdir -p ~/.local/bin

# programs to install
# - lynx
# - pandoc
# - viewmd
# - mdless
# - bat

# install stuff with gem
gem install mdless --user-install > /dev/null 2>&1
if [ ! "$?" ]; then
  echo "Failed to install mdless"
  exit 1
fi

# install stuff from github
LOCATION=$(curl --silent https://api.github.com/repos/sharkdp/bat/releases/latest \
  | grep "tag_name" \
  | awk '{print "https://github.com/sharkdp/bat/releases/download/" substr($2, 2, length($2)-3) "/bat-" substr($2, 2, length($2)-3) "-x86_64-unknown-linux-musl.tar.gz"}') \
  ; curl -L -o bat.tar.gz $LOCATION

mkdir -p bat
tar xf bat.tar.gz -C bat --strip-components=1 && cp bat/bat ~/.local/bin

# Remove all temporary files
rm -rf bat.tar.gz bat

exit 0
