# Dotfiles

Simple macOS shell setup for a fast, clean terminal experience. ✨

> **`work` branch:** a slimmed-down setup for a work machine. It drops personal-only tools, uses mise instead of fnm, tracks VS Code settings and keeps the work git identity out of the repo. Bring shared changes across with `git merge main`.

## What It Does

Running `make` will:

1. 🔗 Write `~/.zshenv` with `XDG_CONFIG_HOME` and `ZDOTDIR`
2. 🧩 Symlink each file from `.config/` into `XDG_CONFIG_HOME` (real dirs; generated files stay in `~/.config`), and `vscode/*.json` into VS Code's user folder (an existing real file is kept as `.bak`)
3. 🍺 Install [Homebrew](https://brew.sh) if missing
4. 📦 Install packages from [Brewfile](.config/homebrew/Brewfile)

## Quick Start

On a new Mac, one command does everything:

```bash
curl -fsSL https://raw.githubusercontent.com/djyoung/dotfiles/work/bootstrap.sh | bash
```

[`bootstrap.sh`](bootstrap.sh) installs Homebrew (and with it the Xcode Command Line Tools), clones this repo to `~/Code/dotfiles` on the `work` branch, runs `make`, asks once for your commit name and work email (written to `~/.config/git/config.local`, never committed), creates an SSH key and runs `gh auth login`. It's safe to re-run; finished steps are skipped. Set `DOTFILES_DIR` to clone somewhere else.

Or by hand:

```bash
git clone --branch work https://github.com/djyoung/dotfiles.git
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
├── git/        # defaults + identity (includes untracked config.local)
├── mise/       # global runtime versions (Node, bun)
├── gh/         # GitHub CLI (config only, not auth)
└── homebrew/   # Brewfile (global bundle, incl. VS Code extensions)
vscode/         # VS Code settings, linked into ~/Library/Application Support/Code/User
bootstrap.sh    # one-shot new-machine setup
```

Files are symlinked one by one, so runtime files (history, `.zcompdump`, compiled Antidote bundles) stay in `~/.config` and out of the repo.

## Tools

- [Antidote](https://antidote.sh) - zsh plugin manager
- [Starship](https://starship.rs) - cross-shell prompt
- [fzf](https://github.com/junegunn/fzf), [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [zoxide](https://github.com/ajeetdsouza/zoxide) - fuzzy finding, search and smarter `cd`
- [Ghostty](https://ghostty.org) - terminal emulator
- [gh](https://cli.github.com) - GitHub CLI
- [mise](https://mise.jdx.dev) - runtime version manager (Node, bun, and anything else a project needs)
- [Fira Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) - prompt/icon glyphs
- [VS Code](https://code.visualstudio.com) - editor, with settings in `vscode/` and extensions in the Brewfile

## Theming

Everything uses [Catppuccin](https://catppuccin.com): Mocha (dark) and Latte (light). Ghostty and VS Code switch automatically with the system appearance; Starship checks the appearance before each prompt and uses a generated copy of its config with a softer pastel Latte palette in light mode. Hex values are duplicated across the app configs, so change them together.

## Zsh

`.zshrc` sources small modules in a fixed order:

| File               | Role                                                          |
| ------------------ | ------------------------------------------------------------- |
| `exports.zsh`      | Env vars (`FZF_DEFAULT_OPTS`, `STARSHIP_CONFIG`); `mise activate` |
| `options.zsh`      | `setopt` options and history-substring-search colors          |
| `plugins.zsh`      | Antidote stage 1: `.zsh_plugins.txt`                          |
| `completion.zsh`   | Docker completions on `fpath`, `compinit -C`, fzf-tab zstyles, alias expansions in command completion |
| `plugins_post.zsh` | Antidote stage 2: `.zsh_plugins_post.txt`                     |
| `keybindings.zsh`  | History substring search on ↑/↓; `fzf --zsh` integration      |
| `navigation.zsh`   | zoxide                                                        |
| `prompt.zsh`       | Starship, with light/dark palette switching                   |
| `aliases.zsh`      | Git, Homebrew, navigation and Claude aliases                  |

### Plugin order

Plugins load in two stages so order-sensitive ones work. Edit `.zsh_plugins.txt` (early: `zsh-completions`) or `.zsh_plugins_post.txt` (after `compinit`: `fzf-tab`, autosuggestions, syntax highlighting, history substring search), then open a new shell or run `reload`.

- `fzf-tab` must load after `compinit` and before plugins that wrap widgets.
- History substring search loads after syntax highlighting; its keybindings are set later in `keybindings.zsh`.
