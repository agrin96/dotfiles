# Dotfiles

MacOS/Linux dotfiles managed with GNU Stow.

## Structure

Each top-level folder is a Stow package.

Examples:

- `zsh` → shell config
- `nvim` → Neovim config
- `wezterm` → WezTerm config
- `starship` → Starship prompt
- `brew` → Homebrew Brewfiles
- `bin` → personal scripts

These packages contain files laid out to mirror their target locations in `$HOME`. Note
some things are ignored such as the vscode/ directory which has vscode profiles.

## Requirements

### macOS

Install these items first:

- Xcode command line tools: `xcode-select --install`
- `git`
- `homebrew`

### Ubuntu

Install `git` first: `sudo apt install git`. The bootstrap script installs all other items. It uses `sudo`, so it asks for your password.

On Ubuntu, the bootstrap script also does these steps:

- It installs the apt packages that Homebrew needs, then Homebrew itself.
- It sets zsh as your default shell.
- If a desktop session is open, it installs WezTerm nightly from the WezTerm apt repository. On a server, it skips WezTerm.

## Usage

```bash
git clone git@github.com:agrin96/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

./bootstrap.sh
```

The bootstrap script stows the packages and installs the `common` brew profile. To see the other profiles, run `setup-brew --list`. To install a profile, run `setup-brew <profile>`.
