export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border'
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/config.toml"

# Node version manager (replaces Homebrew node); switches versions on cd via .nvmrc/.node-version
eval "$(fnm env --use-on-cd --shell zsh)"
