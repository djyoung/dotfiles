# XDG_CONFIG_HOME - override here or: make XDG_CONFIG_HOME=/path/to/config
XDG_CONFIG_HOME ?= $(HOME)/.config

REPO            := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
CONFIG_DIR      := $(REPO)/.config

.DEFAULT_GOAL := all
.PHONY: all help link packages

help:
	@echo "  make            link configs and install packages (default)"
	@echo "  make link       write ~/.zshenv and symlink .config/"
	@echo "  make packages   Homebrew + Brewfile"
	@echo ""
	@echo "  XDG_CONFIG_HOME=$(XDG_CONFIG_HOME)"

all: link packages
	@echo "🚀 Setup complete. Restart your terminal and you're ready to go!"

link:
	@printf '%s\n' \
		'export XDG_CONFIG_HOME="$(XDG_CONFIG_HOME)"' \
		'export ZDOTDIR="$$XDG_CONFIG_HOME/zsh"' \
		> "$(HOME)/.zshenv"
	@echo "📝 Wrote $(HOME)/.zshenv"
	@echo "🔗 Linking into $(XDG_CONFIG_HOME)..."
	@mkdir -p "$(XDG_CONFIG_HOME)"
	@find "$(CONFIG_DIR)" -mindepth 2 -type f | while read -r src; do \
		rel="$${src#$(CONFIG_DIR)/}"; \
		dst="$(XDG_CONFIG_HOME)/$$rel"; \
		mkdir -p "$$(dirname "$$dst")"; \
		ln -sfn "$$src" "$$dst"; \
		printf '  --> %s\n' "$$rel"; \
	done
	@echo "✅ Link step complete\n"
packages:
	@echo "📦 Installing packages..."
	@command -v brew >/dev/null 2>&1 || { \
		echo "🍺 Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	}
	@XDG_CONFIG_HOME=$(XDG_CONFIG_HOME) brew bundle install --global
	@echo "✅ Package step complete\n"
