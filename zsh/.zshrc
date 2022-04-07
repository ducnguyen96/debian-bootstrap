source $ZDOTDIR/zshrc

# fnm
export PATH=/bin/fnm:$PATH
eval "$(fnm env --use-on-cd)"
fnm completions --shell=zsh > $ZDOTDIR/completion/_fnm
