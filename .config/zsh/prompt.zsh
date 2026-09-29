# Starship can't follow the system appearance, so check it before every prompt
# (~5ms) and point STARSHIP_CONFIG at a Latte copy of the config in light mode.
# The copy is generated from config.toml and refreshed whenever it changes.
_starship_dark="${XDG_CONFIG_HOME}/starship/config.toml"
_starship_light="${XDG_CACHE_HOME:-$HOME/.cache}/starship/config-latte.toml"
if [[ ! -f "$_starship_light" || "$_starship_dark" -nt "$_starship_light" ]]; then
  mkdir -p "${_starship_light:h}"
  sed "s/^palette = .*/palette = 'catppuccin_latte'/" "$_starship_dark" >| "$_starship_light"
fi

_starship_appearance() {
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" != Dark ]]; then
    export STARSHIP_CONFIG="$_starship_light"
  else
    export STARSHIP_CONFIG="$_starship_dark"
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _starship_appearance

eval "$(starship init zsh)"
