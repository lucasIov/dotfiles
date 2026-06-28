#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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


# === init other things ===
export PATH="$HOME/.local/bin:$PATH" # add custom and manualy installed programs
export EDITOR="nvim"
export VISUAL="nvim"

export LC_COLLATE="C" # display dotfile first in ls, but may do something else to ?

# ask man to use bat for style
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export LESS='--RAW-CONTROL-CHARS --use-color' # make less show the color send by the pipe

alias l='ls --color=auto --group-directories-first -lAh'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias t='tree -aC --dirsfirst --sort name'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export HISTFILE="$XDG_STATE_HOME"/bash/history


PS1="\e[32m\w\033[0m \e[35m\t\e[0m\n\e[34m\$\e[0m "

# === fetch ===
echo -en "\n  \033[43;30m $(date '+%a %d %B %Y') \033[0m \033[30;107m $USER \033[100;97m $(</etc/hostname) \033[0m \033[44m $(grep -Po "(?<=PRETTY_NAME=\")(.*)(?=\")" /usr/lib/os-release) \033[97;46m ${$(uname -r)%%-*} \033[0m \033[42m ${SHELL##*/} \033[0m $(uptime -p | sed -r 's/up\s//;s/([[:digit:]]+)\s(\w)\w*/\1\2/g;s/,//')\n\n"




