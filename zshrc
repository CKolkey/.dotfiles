# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_CHAR_SYMBOL="> "
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_SYMBOL="\e[39m• \e[35m"
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_PROMPT_DEFAULT_PREFIX=" "
SPACESHIP_RUBY_SYMBOL=" "
SPACESHIP_NODE_SYMBOL=" "
SPACESHIP_EXEC_TIME_PREFIX="("
SPACESHIP_EXEC_TIME_SUFFIX=")"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(
  git
  zsh-syntax-highlighting
  gitfast
  last-working-dir
  common-aliases
  history-substring-search
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/ruby/bin:$PATH"
export LANG=en_US.UTF-8
export EDITOR='nvim'

alias zshconfig="v ~/.zshrc"
alias ohmyzsh="v ~/.oh-my-zsh"
alias v='nvim'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias -- -='cd -'

alias gpom="git pull origin master"
alias gpou='git push -u origin'
alias gmm="git merge master"
alias gcm="git commit -v -m"
alias gco="git checkout"

alias to="touch"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias ip="curl ipinfo.io/ip"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias sha256="openssl dgst -sha256"

# Overmind:
alias os="overmind start"
alias oc="overmind connect"
alias or="overmind restart"
# Quickly serve the current directory as HTTP
alias serve='ruby -run -e httpd . -p 8000'  # Or python -m SimpleHTTPServer :)

# Rails bundler shorter
alias be='bundle exec'
alias bi='bundle install'
alias rrf='rails routes | fzf'

# Load rbenv if installed
export PATH="~/.rbenv/shims:${HOME}/.rbenv/bin:${PATH}"
type -a rbenv > /dev/null && eval "$(rbenv init -)"

export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/Cameron/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;#export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"

# Kitty Setup
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin


export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /Users/Cameron/Library/Preferences/org.dystroy.broot/launcher/bash/br
