#!/usr/bin/env bash
# Set up a new Mac from the work branch. Safe to re-run: finished steps are skipped.
#   curl -fsSL https://raw.githubusercontent.com/djyoung/dotfiles/work/bootstrap.sh | bash
set -euo pipefail

REPO_URL="https://github.com/djyoung/dotfiles.git"
BRANCH="work"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Code/dotfiles}"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Under `curl | bash` stdin is the script, so read answers from the terminal
TTY=/dev/tty

step() { printf '\n\033[1;35m==>\033[0m %s\n' "$1"; }

step "Homebrew"
if ! command -v brew >/dev/null 2>&1; then
  # Also installs the Xcode Command Line Tools, which provide git
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" <"$TTY"
fi
for prefix in /opt/homebrew /usr/local; do
  [[ -x "$prefix/bin/brew" ]] && eval "$("$prefix/bin/brew" shellenv)" && break
done
echo "brew $(brew --version | head -1 | cut -d' ' -f2)"

step "Dotfiles"
if [[ -d "$DOTFILES_DIR/.git" ]]; then
  echo "Already cloned at $DOTFILES_DIR"
  current="$(git -C "$DOTFILES_DIR" branch --show-current)"
  [[ "$current" == "$BRANCH" ]] || echo "⚠️  On branch '$current', not '$BRANCH'; leaving it as is"
else
  mkdir -p "$(dirname "$DOTFILES_DIR")"
  git clone --branch "$BRANCH" "$REPO_URL" "$DOTFILES_DIR"
fi

step "Link configs and install packages"
make -C "$DOTFILES_DIR"

step "Git identity"
GIT_LOCAL="$CONFIG_HOME/git/config.local"
if [[ -f "$GIT_LOCAL" ]]; then
  echo "Using $GIT_LOCAL ($(git config --file "$GIT_LOCAL" user.email || echo 'no email set'))"
else
  default_name="$(git config --global user.name || true)"
  read -r -p "Name for commits [$default_name]: " name <"$TTY"
  read -r -p "Work email for commits: " email <"$TTY"
  mkdir -p "$(dirname "$GIT_LOCAL")"
  git config --file "$GIT_LOCAL" user.name "${name:-$default_name}"
  [[ -n "$email" ]] && git config --file "$GIT_LOCAL" user.email "$email"
  echo "Wrote $GIT_LOCAL"
fi

step "SSH key"
SSH_KEY="$HOME/.ssh/id_ed25519"
if [[ -f "$SSH_KEY" ]]; then
  echo "Already have $SSH_KEY"
else
  mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "$(git config user.email || whoami)" -f "$SSH_KEY" <"$TTY"
  ssh-add --apple-use-keychain "$SSH_KEY" <"$TTY" || true
fi

step "GitHub CLI"
if gh auth status >/dev/null 2>&1; then
  echo "Already signed in"
else
  # Offers to upload the SSH key above to GitHub
  gh auth login --git-protocol ssh <"$TTY"
fi

printf '\n🚀 Done. Open a new terminal (or run `exec zsh`) to start using it.\n'
