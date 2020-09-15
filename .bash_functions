# Bash Functions

# automate X11 DISPLAY reset for better use in tmux
# XXX Sometimes doesn't work
update-x11-forwarding()
{
	if [ -z "$STY" -a -z "$TMUX" ]; then
			echo $DISPLAY > ~/.display.txt
	else
			export DISPLAY=$(cat ~/.display.txt)
	fi
}

# and run this before every command
preexec()
{
	[ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return

	update-x11-forwarding
}

# Find file/directory upwards
find_up()
{
  local x=`pwd`
  local filename=""
  if [ $# -eq 2 ]; then
    x="$1"
    filename="$2"
  else
    filename="$1"
  fi
	while [ "$x" != "/" ] ; do
			found=`find "$x" -maxdepth 1 -name $1`
      if [ ! -z "$found" ]; then
        echo "$found"
        return
      fi
			x=`dirname "$x"`
	done
}
