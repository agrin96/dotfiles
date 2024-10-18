# --------------------------------------------------------------------------------
# Plugins
# --------------------------------------------------------------------------------
# source antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
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
alias cat="bat"
alias catp="bat --plain"
alias lsa="lsd --long --header"
alias xcode="open -a Xcode"
alias adb="/Users/agrin/Library/Android/sdk/platform-tools/adb"
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"


# ALlows activating the pdm venv using a "shell" command like we are used to.
pdm() {
	local command=$1

	if [[ "$command" == "shell" ]]; then
			eval $(pdm venv activate)
	else
			command pdm $@
	fi
}

# --------------------------------------------------------------------------------
# Exports
# --------------------------------------------------------------------------------
# Get rid of annoying folder highlighting and set executable highlighting to purple
export LS_COLORS="ow=0:tw=0:ex=35"
export EDITOR="vim"
export WEZTERM_CONFIG_FILE="~/.config/wezterm/wezterm.lua"

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
