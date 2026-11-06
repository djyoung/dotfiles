# Docker CLI completions (must be on fpath before compinit).
fpath=("${HOME}/.docker/completions" $fpath)

autoload -Uz compinit
compinit -C

# Let fzf-tab capture completions instead of zsh's built-in menu.
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=* l:|=* r:|=*'

zstyle ':fzf-tab:*' continuous-trigger 'tab'
zstyle ':fzf-tab:*' fzf-flags '--layout=reverse'

# List aliases as name='expansion' when completing a command, so Tab doubles as
# an alias reminder. The built-in alias candidates are switched off via
# tag-order below; everything else still comes from _complete.
_alias_complete() {
  if [[ $compstate[context] == command ]]; then
    local -a names disp
    local expl k
    names=( ${(k)aliases} )
    for k in $names; do disp+=( "$k='${aliases[$k]}'" ); done
    _description aliases expl 'alias'
    compadd "$expl[@]" -Q -d disp -a names
  fi
  _complete "$@"
}
zstyle ':completion:*' completer _alias_complete _ignored
zstyle ':completion:*:-command-:*' tag-order '! aliases'
