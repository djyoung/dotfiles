# Dotfiles

Simple macOS shell setup for a fast, clean terminal experience. ✨

## What It Does

Running `make` will:

1. 🔗 Write `~/.zshenv` with `XDG_CONFIG_HOME` and `ZDOTDIR`
2. 🧩 Symlink each file from `.config/` into `XDG_CONFIG_HOME` (real dirs; generated files stay in `~`)
3. 🍺 Install [Homebrew](https://brew.sh) if missing
4. 📦 Install packages from [Brewfile](.config/homebrew/Brewfile)

## Terminal & Prompt

- [Antidote](https://antidote.sh) - Zsh plugin manager
- [Starship](https://starship.rs) - cross-shell prompt
- [Fira Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) - Nerd Font for prompt/icons
- [Ghostty](https://ghostty.org) - terminal emulator

## Quick Start

```bash
git clone https://github.com/djyoung/dotfiles.git
cd dotfiles
make
```

If you do not use the default config path, set `XDG_CONFIG_HOME` at the top of the `Makefile` (or pass it to `make`).

After setup, open a restart your terminal and you're ready to go! 🚀

## Make Targets

| Command             | Description                     |
| ------------------- | ------------------------------- |
| `make` / `make all` | Link configs + install packages |
| `make link`         | Symlinks only                   |
| `make packages`     | Homebrew + Brewfile only        |

## Zsh Behavior

Plugins are listed in `~/.config/zsh/plugins.txt`. After editing, open a new shell or run `antidote load`.
