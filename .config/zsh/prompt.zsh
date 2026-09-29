# Starship can't follow the system appearance, so check it before every prompt
# (~5ms) and point STARSHIP_CONFIG at a light copy of the config in light mode.
# The copy is generated from config.toml and refreshed whenever it or this file
# changes: it uses the softer catppuccin_latte_pastel palette, with the ❯ symbol
# kept in full Latte colours so it stays readable.
_starship_dark="${XDG_CONFIG_HOME}/starship/config.toml"
_starship_light="${XDG_CACHE_HOME:-$HOME/.cache}/starship/config-latte.toml"
if [[ ! -f "$_starship_light" || "$_starship_dark" -nt "$_starship_light" || "${(%):-%x}" -nt "$_starship_light" ]]; then
  mkdir -p "${_starship_light:h}"
  sed -e "s/^palette = .*/palette = 'catppuccin_latte_pastel'/" \
    -e '/_symbol = /{s/fg:green/fg:#40a02b/;s/fg:red/fg:#d20f39/;s/fg:lavender/fg:#7287fd/;s/fg:yellow/fg:#df8e1d/;}' \
    "$_starship_dark" >| "$_starship_light"
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
