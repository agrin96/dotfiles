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

Install these basics first:

- `git`
- `stow`
- `homebrew`

On macOS, you also need to install Xcode command line tools:

```bash
xcode-select --install
```

### Usage
```bash
git clone git@github.com:agrin96/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

./bootstrap.sh
```

The bootstrap script will set up stow packages and install a common brew profile. If you
need to install additional brew profiles run `brew-setup.sh --list` and then install with
`brew-setup.sh <profile>`

