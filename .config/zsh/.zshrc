source "${ZDOTDIR}/exports.zsh"
source "${ZDOTDIR}/aliases.zsh"

source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
antidote load

eval "$(starship init zsh)"
