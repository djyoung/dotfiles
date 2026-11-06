export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border'
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/config.toml"

# Runtime manager (Node, bun, etc.): global defaults in mise/config.toml,
# per-project versions from mise.toml, .nvmrc or .node-version on cd
eval "$(mise activate zsh)"
