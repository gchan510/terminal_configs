# Aliases for bash commands (only sourced in interactive shells)

alias ls='ls --color=auto'
alias ll='ls -alh'

alias tmux="tmux -2"
alias tmuxa="tmux -2 attach -t"
alias regrep="grep --color --exclude-dir=.svn --exclude-dir=.git --exclude tags --exclude=*.bc --exclude=*.o --exclude=*.so --exclude=*.swp"
alias regrepc="grep --color --include=\*.{c,cpp,h,hpp}"
