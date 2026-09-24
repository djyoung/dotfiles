# Docker CLI completions (must be on fpath before compinit).
fpath=("${HOME}/.docker/completions" $fpath)

autoload -Uz compinit
compinit -C

# Let fzf-tab capture completions instead of zsh's built-in menu.
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=* l:|=* r:|=*'

zstyle ':fzf-tab:*' continuous-trigger 'tab'
zstyle ':fzf-tab:*' fzf-flags '--layout=reverse'
