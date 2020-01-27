# Oh My ZSH Stuff
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(
  vi-mode
  colored-man-pages
  postgres
  autoupdate
  git
  gitfast
  last-working-dir
  common-aliases
  history-substring-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# User configuration
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color
export UPDATE_ZSH_DAYS=1

# Vi-Mode
export KEYTIMEOUT=1
export RPS1="%{$reset_color%}" # Must be before oh-my-zsh source

# History
HISTFILE=$HOME/.cache/zsh/history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances of the shell

# Sourcing other files
source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions
source $HOME/.dotfiles/zsh/prompt
source $HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br

# ZSH Options
setopt auto_cd       # cd by typing the dir name if its not a command name
setopt correct_all   # autocorrect commandsl
setopt auto_list     # automatically list choices on ambiguous completion
setopt auto_menu     # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

# History Substring Search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/Cameron/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH

# Autocompletion and Kitty
autoload -Uz compinit

# Cache completion list for faster load times
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist
kitty + complete setup zsh | source /dev/stdin

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Update hombrew once a week
export HOMEBREW_AUTO_UPDATE_SECS=600000

# Load rbenv if installed
# export PATH="${HOME}/.rbenv/bin:${PATH}"
type -a rbenv > /dev/null && eval "$(rbenv init -)"

export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"
