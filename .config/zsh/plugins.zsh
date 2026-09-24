# Stage 1: plugins that only need to be on fpath before compinit
# (.zsh_plugins.txt). Stage 2 lives in plugins_post.zsh.
source "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh"
antidote load
