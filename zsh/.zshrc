# --------------------------------------------------------------------------------
# Plugins
# --------------------------------------------------------------------------------
# source antidote
source $(brew --prefix antidote)/share/antidote/antidote.zsh
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
alias adb="/Users/agrin/Library/Android/sdk/platform-tools/adb"
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

# Tree preview view for the fzf command. We ignore a bunch of crap
export FZF_LSD_IGNORES="--ignore-glob '.venv'\
 --ignore-glob '__pycache__'\
 --ignore-glob '.pyc'\
 --ignore-glob '.cpython'\
 --ignore-glob '.vscode'\
 --ignore-glob '.pytest_cache'"
export FZF_LSD_PREVIEW="lsd --color always --icon always --tree $FZF_LSD_IGNORES"

# FZF should by default look only for directories and skip .git node etc.
# NOTE: If the options are not exactly 1 space apart this whole thing blows up.
# It also doesn't like being multilined.
 export FZF_DEFAULT_EXCLUDE="! -path '*.git*'\
 ! -path '*node_modules*'\
 ! -path '*.venv*'\
 ! -path '*__pycache__*'\
 ! -path '*.pyc*'\
 ! -path '*.cpython*'\
 ! -path '*.vscode*'\
 ! -path '*.pytest_cache*'"

export FZF_LIST_DIRECTORIES="find . -type d $FZF_DEFAULT_EXCLUDE"
export FZF_LIST_FILES="find . -type f $FZF_DEFAULT_EXCLUDE"
# This Env var what is actually read by fzf
export FZF_DEFAULT_COMMAND=$FZF_LIST_DIRECTORIES

# Default arguments for FZF.
# We have to escape certain commands if they use quote characters for options as
# is the case for a lot of our FZF options
export FZF_DEFAULT_OPTS="
 --prompt 'directories > '
 --pointer '○'
 --marker '⏺'
 --height 100%
 --preview \"$FZF_LSD_PREVIEW -d {}\"
 --preview-window 'top,70%'
 --layout reverse-list
 --border
 --info inline
 --multi
 --bind 'del:execute(rm -ri {+})'
 --bind \"del:+reload($FZF_LIST_DIRECTORIES)\"
 --bind 'ctrl-p:toggle-preview'
 --bind 'ctrl-/:change-preview-window(down|hidden|)'
 --bind 'ctrl-d:change-prompt(directories > )'
 --bind \"ctrl-d:+reload($FZF_LIST_DIRECTORIES)\"
 --bind 'ctrl-d:+change-preview($FZF_LSD_PREVIEW -d {})'
 --bind 'ctrl-d:+refresh-preview'
 --bind \"ctrl-s:+change-preview($FZF_LSD_PREVIEW {})\"
 --bind 'ctrl-f:change-prompt(files > )'
 --bind \"ctrl-f:+reload($FZF_LIST_FILES)\"
 --bind 'ctrl-f:+refresh-preview'
 --bind 'ctrl-f:+change-preview(bat -n -r :100 --color=always {})'
 --bind \"ctrl-r:reload($FZF_LIST_DIRECTORIES)\"
 --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)'
 --color header:italic
 --header '
CTRL+D directories | CTRL+F files | CTRL+R reload
CTRL+/ move preview window | CTRL+Y copy | DEL delete
CTRL-S directories & files | CTRL+P toggle preview'"

# Arguments for searching in history
export FZF_CTRL_R_OPTS="
 --prompt 'command >'
 --preview ''
 --color header:italic
 --header 'CTRL+R reload | CTRL+Y copy to clipboard'"

# --------------------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------------------
# Our fzf wrapper that allows cd and opening files in editor
function ff(){
	local selection=$(fzf -i)
	if [ -z "$selection" ]; then
		return 0
	fi

	# If this is a directory then just CD if this is a file then open it in our
	# default editor.
	if [ -d $selection ]; then
		cd "$selection" || exit
	else
		eval "$EDITOR $selection"
	fi
}

# For developing android applications we can source android paths for the current shell
setup_android() {
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  echo "Android SDK paths configured"
  echo "Android Home: $ANDROID_HOME"
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
    print "  <C-d> directories"  
    print "  <C-f> files" 
    print "  <C-r> reload"
    print "  <C-p> toggle preview"
    print "  <C-/> move preview"
    print "  <C-y> copy"
    print "  <Del> delete"
    print ""
    print -P "%B%F{green}Other%f%b"
    print "  venv            activate python .venv"
    print "  setup_android   configure ANDROID_HOME + SDK paths"
    print ""
}

# --------------------------------------------------------------------------------
# Miscillaneous Setup 
# --------------------------------------------------------------------------------
# Bun setup 
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/agrin/.bun/_bun" ] && source "/Users/agrin/.bun/_bun"

# Nim
export PATH=/Users/agrin/.nimble/bin:$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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
