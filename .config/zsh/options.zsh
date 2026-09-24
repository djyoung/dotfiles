# Directory navigation
setopt autocd extendedglob globdots
setopt auto_pushd pushd_ignore_dups pushdminus

# History
setopt extended_history hist_verify share_history inc_append_history

# Completion
setopt complete_in_word always_to_end

# Misc
setopt interactivecomments noclobber

# zsh-history-substring-search (must be set before plugin loads)
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=111,underline'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=203'
