# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# === XDG ===
# follow xdg spec, see: https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# force other software to follow the xdg spec
export CARGO_HOME="$XDG_DATA_HOME"/cargo # for cargo
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export PROXYCHAINS_CONF_FILE="$XDG_CONFIG_HOME"/proxychains.conf # TODO: proxychains return error
alias irssi="irssi --config="$XDG_CONFIG_HOME"/irssi/config --home="$XDG_DATA_HOME"/irssi"

# === zsh ===
export HISTFILE="$XDG_STATE_HOME"/zsh/zsh_history
export HISTSIZE=50000
export SAVEHIST=10000

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands if the line start with a <space>
setopt extended_history       # add timestamps and duration to history file
setopt hist_find_no_dups      # do not display duplicated commands in history search
setopt hist_reduce_blanks     # remove superfluous blanks from each command line being added to the history file
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # append history and read new history lines from HISTFILE heach time the prompt is displayed (don't work well with inc_append_history)
# setopt inc_append_history     # append history immediately, faster but don't allow access to previous commands in the other shell sessions (don't work with share_history)
setopt globdots               # include dotfiles in filename generation
# setopt autocd                 # change to a directory by typing its name
setopt cdsilent               # don't print directory when using 'cd'
setopt numericglobsort        # sort filenames numerically when it makes sense (forgot what for, but i think it's for the fzf plugin)

zstyle :compinstall filename "$HOME/.zshrc"
autoload -U compinit && compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
autoload zmv # see: github.com/zsh-users/zsh/blob/master/Functions/Misc/zmv
autoload -U tetriscurses

zstyle ':completion:*' menu select       # enable menu selection (arrow keys to navigate, and show current selection)
zstyle ':completion:*' file-sort name    # self explanatory
# zstyle ':completion:*' special-dirs true # include . & .. in the path completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no           # avoid conflict with fzf-tab

zstyle ':completion:*:descriptions' format '[%d]' # show groups for fzf-tab


# Key bindings
bindkey -e                                        # emacs key bindings
bindkey '^[[1;7D' beginning-of-line               # ctrl + alt + <-
bindkey '^[[1;7C' end-of-line                     # ctrl + alt + ->
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[A' history-beginning-search-backward  # up arrow
bindkey '^[[B' history-beginning-search-forward   # down arrow
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[Z' undo                               # shift + tab undo last action
bindkey '^H' backward-delete-word                 # ctrl + backspace
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey ' ' magic-space                           # do history expansion on space ( sudo !! -> sudo ....)
# see: https://zsh.sourceforge.io/Doc/Release/Expansion.html

# === init other things ===
export PATH="$HOME/.local/bin:$PATH" # add custom and manualy installed programs
export EDITOR="nvim"
export VISUAL="nvim"

# TODO: LS_COLORS

export LC_COLLATE="C" # display dotfile first in ls, but may do something else to ?

# ask man to use bat for style
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANROFFOPT="-c"
# ask man to use nvim for style & interactivity
export MANPAGER='nvim +Man!'

export LESS='--RAW-CONTROL-CHARS --use-color' # make less show the color send by the pipe

alias l='ls --color=auto --group-directories-first -lAh'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias t='tree -aC --dirsfirst --sort name -I ".git/*"'

# === just pretty things ===
# fastfetch -c ~/.config/fastfetch/ff.json
#if type -a customfetch &> /dev/null; then
#    customfetch
#else
    echo -en "\n  \033[43;30m $(date '+%a %d %B %Y') \033[0m \033[30;107m $USER \033[100;97m $(</etc/hostname) \033[0m \033[44m $(grep -Po "(?<=PRETTY_NAME=\")(.*)(?=\")" /usr/lib/os-release) \033[97;46m ${$(uname -r)%%-*} \033[0m \033[42m ${0##*/} \033[0m $(uptime -p | sed -r 's/up\s//;s/([[:digit:]]+)\s(\w)\w*/\1\2/g;s/,//')\n\n"
#fi
eval "$(posh init zsh --config ~/.config/posh/my.json)"
# TODO replace posh

eval "$(fzf --zsh)"

# === ZSH PLUGINS ===
export ZSH_PLUGINS_DIR=${XDG_DATA_HOME}/zsh/plugins/

# === fzf-tab ===
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # show directory preview
source ${ZSH_PLUGINS_DIR}/fzf-tab/fzf-tab.plugin.zsh # https://github.com/Aloxaf/fzf-tab
source ${ZSH_PLUGINS_DIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
