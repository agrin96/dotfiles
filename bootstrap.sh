#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
PACKAGES=(zsh bin brew wezterm starship nvim lsd htop neofetch)

log() {
    printf '\n==> %s\n' "$1"
}

have() {
    command -v "$1" >/dev/null 2>&1
}

if ! have brew; then
    echo "Homebrew is not installed. Install it first, then rerun bootstrap.sh."
    exit 1
fi

if ! have git || ! have stow; then
    log "Installing git and stow"
    brew install git stow
fi

cd "$DOTFILES_DIR"

for pkg in "${PACKAGES[@]}"; do
    if [[ -d "$pkg" ]]; then
        log "Stowing $pkg"
        stow "$pkg"
    fi
done

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

log "Installing Brew profile common"
setup-brew common

log "Bootstrap complete"
echo "Open a new shell or run: exec zsh"
