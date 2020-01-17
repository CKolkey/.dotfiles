# Oh My ZSH Stuff
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(
  postgres
  git
  zsh-syntax-highlighting
  gitfast
  last-working-dir
  common-aliases
  history-substring-search
  zsh-autosuggestions
)

# User configuration
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color

# Sourcing other files
source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions
source $HOME/.dotfiles/zsh/prompt
source $HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/Cameron/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH

# Kitty
autoload -Uz compinit
compinit
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
