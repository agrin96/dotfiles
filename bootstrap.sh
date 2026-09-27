#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
PACKAGES=(zsh bin brew wezterm starship nvim lsd htop)
LINUX_BREW="/home/linuxbrew/.linuxbrew/bin/brew"

log() {
    printf '\n==> %s\n' "$1"
}

have() {
    command -v "$1" >/dev/null 2>&1
}

# Ubuntu: apt packages that Homebrew and the default shell need, then Homebrew itself.
install_linux_prerequisites() {
    log "Installing apt prerequisites"
    sudo apt-get update
    sudo apt-get install -y build-essential procps curl file git gnupg unzip zsh

    if [[ ! -x "$LINUX_BREW" ]]; then
        log "Installing Homebrew"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$("$LINUX_BREW" shellenv)"

    if [[ "$SHELL" != */zsh ]]; then
        log "Setting zsh as the default shell"
        sudo chsh -s /usr/bin/zsh "$USER"
    fi
}

# The Homebrew cask is macOS only. See https://wezterm.org/install/linux.html
install_linux_wezterm() {
    log "Installing WezTerm nightly from the WezTerm apt repository"
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
    sudo apt-get update
    sudo apt-get install -y wezterm-nightly
}

if [[ "$(uname -s)" == "Linux" ]]; then
    install_linux_prerequisites

    if [[ -n "${XDG_CURRENT_DESKTOP:-}" ]]; then
        install_linux_wezterm
    else
        log "No desktop session found, skipping WezTerm"
    fi
fi

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
        # bin: link each script into a real ~/.local/bin, so tools that install
        # there (uv, pipx) do not write into this repo. --restow also unfolds a
        # ~/.local/bin link left by an older bootstrap.
        if [[ "$pkg" == "bin" ]]; then
            stow --restow --no-folding "$pkg"
        else
            stow "$pkg"
        fi
    fi
done

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

log "Installing Brew profile common"
setup-brew common

log "Bootstrap complete"
echo "Open a new shell or run: exec zsh"
