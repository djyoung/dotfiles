bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# Loads after fzf-tab on purpose: fzf captures the current Tab binding
# (fzf-tab) as its fallback completion, so plain Tab still goes through fzf-tab.
eval "$(fzf --zsh)"
