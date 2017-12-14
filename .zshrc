# Fix Keyboard
autoload zkbd
[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-:1 ]] && zkbd
source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-:1

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# History File
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

# History Size
HISTSIZE=10000
SAVEHIST=10000

# History Features
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history

# Allow auto-completing '..' and '.'
zstyle ':completion:*' special-dirs true

# Various Environment Vars
export KOPS_STATE_STORE=s3://kops.blackwoodseven.com
export EDITOR=nano
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=8
export KOPS_FEATURE_FLAGS="+DrainAndValidateRollingUpdate"
export GOPATH=$HOME/Code/go
export PATH=$PATH:$HOME/.local/opt/android-sdk/platform-tools:$HOME/.local/opt/android-sdk/tools
export AWS_PROFILE=default
export FIREFOX_DEVELOPER_BIN=/opt/firefox-dev/firefox
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# Bind Alt-forward and Alt-backwards to forward-word and backward-word
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word

# Load zPlug
source ~/.zplug/init.zsh

# Prepare Plugins (oh-my-zsh)
zplug "plugins/aws", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/lein", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/thefuck", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh

# Prepare Plugins (zsh-users)
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

# Prepare Theme
# zplug 'themes/agnoster', from:oh-my-zsh
zplug 'zakaziko99/agnosterzak-ohmyzsh-theme', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Load plugins and theme
zplug load

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Enable SDKMAN (for gradle)
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Travis-cli
[ -f /home/frederiknjs/.travis/travis.sh ] && source /home/frederiknjs/.travis/travis.sh
