source $ZDOTDIR/zshrc

# fnm
export PATH=/bin/fnm:$PATH
eval "$(fnm env --use-on-cd)"

# fnm
export PATH=/home/d/.fnm:$PATH
eval "`fnm env`"
