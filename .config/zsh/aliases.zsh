# Git
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gca='git commit --amend --no-edit'
alias gcm='git commit --message'
alias gcam='git commit --all --message'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gfp='git fetch && git pull'
alias gl='git log'
alias glo='git log --oneline --all --graph --decorate --color'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show'
alias gstu='git stash push --include-untracked'
alias gsw='git switch'
alias gswc='git switch --create'

# Homebrew
alias bi='brew install'
alias bic='brew install --cask'
alias bif='brew info'
alias bl='brew list'
alias bs='brew search'
alias bu='brew uninstall'
alias buc='brew uninstall --cask'
alias buu='brew update && brew upgrade --no-ask'

# Navigation & shell
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lAh'
alias reload='exec zsh'

# lazygit can't follow the system appearance, so pick the theme at launch:
# Mocha lives in config.yml, Latte overrides are layered on in light mode.
lg() {
  local dir="${XDG_CONFIG_HOME:-$HOME/.config}/lazygit"
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" != Dark ]]; then
    LG_CONFIG_FILE="$dir/config.yml,$dir/theme-light.yml" lazygit "$@"
  else
    lazygit "$@"
  fi
}

# btop can't follow the system appearance either and has no theme flag, so in
# light mode launch it with a generated copy of btop.conf that uses Latte.
# Settings btop saves on exit in light mode go to that copy and aren't kept.
btop() {
  local dir="${XDG_CONFIG_HOME:-$HOME/.config}/btop"
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" != Dark ]]; then
    local conf="${XDG_CACHE_HOME:-$HOME/.cache}/btop/btop-latte.conf"
    mkdir -p "${conf:h}"
    sed 's/^color_theme = .*/color_theme = "catppuccin_latte"/' "$dir/btop.conf" >| "$conf"
    command btop --config "$conf" --themes-dir "$dir/themes" "$@"
  else
    command btop "$@"
  fi
}

# Claude
alias cc='claude'
