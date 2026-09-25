# Dotfiles

Simple macOS shell setup for a fast, clean terminal experience. ✨

## What It Does

Running `make` will:

1. 🔗 Write `~/.zshenv` with `XDG_CONFIG_HOME` and `ZDOTDIR`
2. 🧩 Symlink each file from `.config/` into `XDG_CONFIG_HOME` (real dirs; generated files stay in `~/.config`)
3. 🍺 Install [Homebrew](https://brew.sh) if missing
4. 📦 Install packages from [Brewfile](.config/homebrew/Brewfile)

## Quick Start

```bash
git clone https://github.com/djyoung/dotfiles.git
cd dotfiles
make
```

If you do not use the default config path, set `XDG_CONFIG_HOME` at the top of the `Makefile` (or pass it to `make`).

After setup, restart your terminal and you're ready to go! 🚀

## Make Targets

| Command             | Description                     |
| ------------------- | ------------------------------- |
| `make` / `make all` | Link configs + install packages |
| `make link`         | Symlinks only                   |
| `make packages`     | Homebrew + Brewfile only        |
| `make help`         | List targets                    |

## Layout

```
.config/
├── zsh/        # ZDOTDIR: modular zsh config
├── starship/   # prompt
├── ghostty/    # terminal
├── git/        # defaults + identity
├── lazygit/    # git TUI
├── herdr/      # terminal workspace manager
├── hunk/       # diff viewer
├── zed/        # editor
├── btop/       # resource monitor (+ Catppuccin theme)
├── opencode/   # AI coding agent
├── gh/         # GitHub CLI (config only, not auth)
└── homebrew/   # Brewfile (global bundle)
```

Files are symlinked one by one, so runtime files (history, `.zcompdump`, compiled Antidote bundles) stay in `~/.config` and out of the repo.

## Tools

- [Antidote](https://antidote.sh) - zsh plugin manager
- [Starship](https://starship.rs) - cross-shell prompt
- [fzf](https://github.com/junegunn/fzf), [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [zoxide](https://github.com/ajeetdsouza/zoxide) - fuzzy finding, search and smarter `cd`
- [Ghostty](https://ghostty.org) - terminal emulator
- [btop](https://github.com/aristocratos/btop), [opencode](https://opencode.ai), [gh](https://cli.github.com) - resource monitor, AI coding agent and GitHub CLI
- [Fira Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) - prompt/icon glyphs
- [lazygit](https://github.com/jesseduffield/lazygit), [herdr](https://herdr.dev), [hunk](https://hunk.dev), [Zed](https://zed.dev) - git TUI, workspace manager, diff viewer and editor

## Theming

Everything uses [Catppuccin](https://catppuccin.com): Mocha (dark) and Latte (light). Ghostty, Zed and herdr switch automatically with the system appearance; Starship is set to `catppuccin_mocha`; lazygit and btop are Mocha-only. Hex values are duplicated across the app configs, so change them together.

## Zsh

`.zshrc` sources small modules in a fixed order:

| File               | Role                                                          |
| ------------------ | ------------------------------------------------------------- |
| `exports.zsh`      | Env vars (`FZF_DEFAULT_OPTS`, `STARSHIP_CONFIG`)              |
| `options.zsh`      | `setopt` options and history-substring-search colors          |
| `plugins.zsh`      | Antidote stage 1: `.zsh_plugins.txt`                          |
| `completion.zsh`   | Docker completions on `fpath`, `compinit -C`, fzf-tab zstyles |
| `plugins_post.zsh` | Antidote stage 2: `.zsh_plugins_post.txt`                     |
| `keybindings.zsh`  | History substring search on ↑/↓; `fzf --zsh` integration      |
| `navigation.zsh`   | zoxide                                                        |
| `prompt.zsh`       | Starship                                                      |
| `aliases.zsh`      | Git, Homebrew, navigation and Claude aliases                  |

### Plugin order

Plugins load in two stages so order-sensitive ones work. Edit `.zsh_plugins.txt` (early: `zsh-completions`) or `.zsh_plugins_post.txt` (after `compinit`: `fzf-tab`, autosuggestions, syntax highlighting, history substring search), then open a new shell or run `reload`.

- `fzf-tab` must load after `compinit` and before plugins that wrap widgets.
- History substring search loads after syntax highlighting; its keybindings are set later in `keybindings.zsh`.
