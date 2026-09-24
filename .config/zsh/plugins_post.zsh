# Stage 2: plugins that must load after compinit (.zsh_plugins_post.txt).
# fzf-tab must come after compinit and before widget-wrapping plugins.
antidote load "${ZDOTDIR}/.zsh_plugins_post.txt"
