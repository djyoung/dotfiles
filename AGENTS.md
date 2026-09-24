# AGENTS.md

Personal macOS dotfiles: a modular zsh setup plus configs for a handful of terminal tools, installed with `make`. See [README.md](README.md) for the user-facing overview.

## How it works

- `make link` writes `~/.zshenv` (exports `XDG_CONFIG_HOME` and `ZDOTDIR=$XDG_CONFIG_HOME/zsh`) and symlinks **each file** under `.config/<tool>/` into `$XDG_CONFIG_HOME/<tool>/`. Directories are real, only files are links.
- `make packages` installs Homebrew if missing, then runs `brew bundle install --global` against `.config/homebrew/Brewfile`.
- Because files are symlinked, editing a file in this repo takes effect immediately in `~/.config`. Runtime files (zsh history, `.zcompdump`, Antidote bundles, herdr logs and sockets, etc.) live in `~/.config` and must never be added to the repo.
- A **new** file needs `make link` to get its symlink. Only files nested at least one directory deep under `.config/` are linked (`find -mindepth 2`), so nothing goes directly in `.config/`.

## Layout

```
.config/
├── zsh/        # ZDOTDIR, modular zsh config
├── starship/   # prompt
├── ghostty/    # terminal
├── git/        # defaults + identity
├── lazygit/    # git TUI
├── herdr/      # terminal workspace manager
├── hunk/       # diff viewer
├── zed/        # editor
└── homebrew/   # Brewfile (global bundle)
Makefile        # link + packages targets
```

## Zsh conventions

`.zshrc` only sources modules, in a fixed order that matters:

`exports` → `options` → `plugins` (Antidote stage 1) → `completion` (`compinit -C`) → `plugins_post` (Antidote stage 2) → `keybindings` → `navigation` → `prompt` → `aliases`

- Add config to the module that owns that concern; create a new `*.zsh` module (and source it in `.zshrc` at the right position) rather than growing `.zshrc`.
- Plugins load in two stages. Plugins that only need to be on `fpath` before `compinit` go in `.zsh_plugins.txt`. Anything that must load after `compinit` goes in `.zsh_plugins_post.txt`. `fzf-tab` must come after `compinit` and before plugins that wrap widgets, and history-substring-search loads after syntax highlighting. Keep that ordering when editing.
- Keep `.zshrc` and modules free of machine-specific paths or secrets. `.zprofile` handles Homebrew's `shellenv`.
- Check syntax with `zsh -n <file>`, and test changes by running `reload` (alias for `exec zsh`) or opening a new shell.

## Other conventions

- **Theming:** everything uses Catppuccin, Mocha (dark) and Latte (light). Hex values are duplicated across the Ghostty, Zed, herdr, lazygit and Starship configs, so a color change must be applied to all of them.
- **Brewfile:** entries are grouped under comment headers (Taps, Shell & terminal, Dev tools, Editors, AI tools, Fonts, Productivity & utilities). Add new packages to the matching group, alphabetized within it, using `cask` for GUI apps.
- **Git identity** lives in `.config/git/config`. Don't change the user name or email.
- **README:** if you add or remove a tool, module or Make target, update the Layout / Tools / Zsh tables in `README.md` to match.

## Working in this repo

- Prefer editing the repo copy (which the symlinks point to) over files in `~/.config`. Don't replace a symlink with a regular file.
- `make link` is idempotent (`ln -sfn`) and safe to re-run, but it overwrites `~/.zshenv`. `make packages` installs software, so don't run it unless the task requires it.
- There is no test suite. Verify changes with `zsh -n`, `make -n`, and a fresh shell where relevant.
- Commit with short conventional-style messages (e.g. `feat: ...`, `fix: ...`, `docs: ...`). Changes land through pull requests, not direct pushes to `main`.
