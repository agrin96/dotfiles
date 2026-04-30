BREW_PREFIX=$(brew --prefix)
# --------------------------------------------------------------------------------
# Plugins
# --------------------------------------------------------------------------------
# source antidote
source $BREW_PREFIX/share/antidote/antidote.zsh
# Actual plugins are found in .zsh_plugins.txt, this will initialize them.
antidote load

# --------------------------------------------------------------------------------
# Plugin Settings
# --------------------------------------------------------------------------------
# Set up fzf key bindings and fuzzy completion.
# See https://thevaluable.dev/practical-guide-fzf-example/ for fzf guide
source <(fzf --zsh)

# Initialize starship promprt usage.
eval "$(starship init zsh)"
# --------------------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------------------
alias ls="lsd --date relative"
alias la="ls -a"
alias ll="ls -la"
alias lt="ls --tree"
alias lta="ls -a --tree"
alias cat="bat"
alias catp="bat --plain"
alias lsa="lsd --long --header"
alias xcode="open -a Xcode"
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"
alias v="nvim"
alias vv="nvim ."
alias venv='source .venv/bin/activate'

# --------------------------------------------------------------------------------
# Exports
# --------------------------------------------------------------------------------
# Get rid of annoying folder highlighting and set executable highlighting to purple
export LS_COLORS="ow=0:tw=0:ex=35:di=38;2;255;179;102"
export EDITOR="nvim"
export WEZTERM_CONFIG_FILE="~/.config/wezterm/wezterm.lua"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

# Add the .local/bin to path so we can add user scripts with Stow
export PATH="$HOME/.local/bin:$PATH"

# Tree preview view for the fzf command. We ignore a bunch of useless things
export FZF_LSD_IGNORES="--ignore-glob '.venv'\
 --ignore-glob '__pycache__'\
 --ignore-glob '.pyc'\
 --ignore-glob '.cpython'\
 --ignore-glob '.vscode'\
 --ignore-glob '.pytest_cache'"
export FZF_LSD_PREVIEW="lsd --color always --icon always --tree $FZF_LSD_IGNORES"

export FZF_LIST_DIRECTORIES="fd --type d --hidden --exclude .git"
export FZF_LIST_FILES="fd --type f --hidden --exclude .git"

export FZF_CTRL_T_COMMAND=$FZF_LIST_FILES
export FZF_CTRL_T_OPTS="--preview 'bat -n -r :100 --color=always {}'"

# The filetree is much flatter so we can do preview 30%
export FZF_ALT_C_COMMAND=$FZF_LIST_DIRECTORIES
export FZF_ALT_C_OPTS="
 --preview '$FZF_LSD_PREVIEW -d {}'
 --preview-window 'right,30%'"

# Arguments for searching in history
export FZF_CTRL_R_OPTS="
 --prompt 'command >'
 --preview ''
 --color header:italic"

# This Env var what is actually read by fzf
export FZF_DEFAULT_COMMAND=$FZF_LIST_DIRECTORIES

# Default arguments for FZF.
# We have to escape certain commands if they use quote characters for options as
# is the case for a lot of our FZF options
export FZF_DEFAULT_OPTS="
 --style full
 --pointer '○'
 --marker '⏺'
 --height 100%
 --preview \"$FZF_LSD_PREVIEW -d {}\"
 --preview-window 'right,50%'
 --layout reverse-list
 --info inline
 --multi
 --bind 'result:transform-list-label:\
    if [[ -z \$FZF_QUERY ]]; then \
        echo \" \$FZF_MATCH_COUNT items \"; \
    else \
        echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"; \
    fi'
 --bind 'ctrl-p:toggle-preview'
 --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)'
 --color bg:#1c2025,fg:#e3e2d9,hl:#61a670
 --color pointer:#654C78,bg+:#654C78,info:#7CAAD9
 --color gutter:#1c2025
 --color header:italic"


# --------------------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------------------
# Our fzf wrapper that allows cd and opening files in editor
function ff(){
    local selection=$(fzf -i)
    [[ -z "$selection" ]] && return 0

	# If this is a directory then just CD if this is a file then open it in our
	# default editor.
	if [[ -d "$selection" ]]; then
		cd "$selection"
	else
		"$EDITOR" "$selection"
	fi
}

help() {
    print -P "%B%F{cyan}######################## Shell Help ########################%F%B"
    print -P "%B%F{blue}Files%f%b"
    print "  ff              FZF picker for cd/open"
    print "  ls              lsd --date relative"
    print "  la ll lt lsa    lsd variants (all)(long)(tree)(all-long)"
    print "  zmv             regex file moves (-n dryrun) (-i interactive)"
    print ""
    print -P "%B%F{red}Editors/Viewers%f%b"
    print "  cat         bat"
    print "  catp        bat --plain"
    print "  <C-xC-e>    edit current command in \$EDITOR"
    print "  <C-xu>      undo command-line edit"
    print ""
    print -P "%B%F{green}FZF%f%b"
    print "  <ALT-c> directories"  
    print "  <C-t> files" 
    print "  <C-p> toggle preview"
    print "  <C-y> copy"
    print ""
    print -P "%B%F{green}Other%f%b"
    print "  venv            activate python .venv"
    print ""
}

# --------------------------------------------------------------------------------
# Miscillaneous Setup 
# --------------------------------------------------------------------------------
# Bun setup 
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Nim
export PATH="$HOME/.nimble/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$BREW_PREFIX/nvm/nvm.sh" ] && . "$BREW_PREFIX/nvm/nvm.sh"
[ -s "$BREW_PREFIX/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_PREFIX/nvm/etc/bash_completion.d/nvm"

# For developing android applications we can source android paths for the current shell
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# --------------------------------------------------------------------------------
# ZSH Setup 
# --------------------------------------------------------------------------------
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# zsh undo is bound to <C-xu>

# This allows regex file moves
autoload zmv

# Run functions on directory change. 
chpwd() {
    # Matches our ls alias since you cant run an alias as a function.
    command lsd --date relative
}

# Allows local overrides for zshrc.
if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi
