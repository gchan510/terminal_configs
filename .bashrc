#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source bash functions
[ -f ~/.bash_functions ] && source ~/.bash_functions

# Update DISPLAY variable whenever
trap 'preexec' DEBUG

# Change this if your terminal doesn't support this
export TERM=xterm-256color

export EDITOR=vim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

PS1='[\t -- \u@\h \W]\$ '

export PATH=$HOME/.local/bin:$PATH

# Source aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Source stuff for fzf to work
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
