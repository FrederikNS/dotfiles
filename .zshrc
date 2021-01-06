# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# hide cdpath suggestions from plain cd
zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
    'local-directories named-directories'

# Various Environment Vars
export EDITOR=nano
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=8
export KOPS_STATE_STORE=s3://kops.infra.core.siteimprove.systems
export KOPS_STATE_S3_ACL=bucket-owner-full-control
#export KOPS_FEATURE_FLAGS="+DrainAndValidateRollingUpdate"
export GOPATH=$HOME/code/go
export PATH=$PATH:$HOME/code/siteimprove/coreinfra-scripts:/var/lib/snapd/snap/bin:$HOME/.local/bin:$HOME/.cargo/bin:$GOPATH/bin:$HOME/.krew/bin:$HOME/.local/opt/android-sdk/platform-tools:$HOME/.local/opt/android-sdk/tools
export AWS_PROFILE=default
export FIREFOX_DEVELOPER_BIN=/opt/firefox-dev/firefox
export WORDCHARS='*?_[]~=&;!#$%^(){}<>'
export MOZ_USE_XINPUT2=1

#setopt auto_cd
cdpath=($HOME .. ../.. $HOME/code/siteimprove $HOME/code/personal $HOME/open-source/)

# Bind Alt-forward and Alt-backwards to forward-word and backward-word
zle -N backward-word backward-word-end
backward-word-end() {
  # Move to the beginning of the current word.
  zle .backward-word

  # If we're at the beginning of the buffer, we don't need to do anything else.
  if (( CURSOR > 0 )); then
    # Otherwise, move to the end of the word before the current one.
    zle .backward-word
    zle .emacs-forward-word
  fi
}

bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' emacs-forward-word

bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

autoload -Uz compinit
compinit

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
### End of Zinit's installer chunk

zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
                zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word

# Prepare Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

. $HOME/.asdf/asdf.sh

source /usr/share/doc/find-the-command/ftc.zsh

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias arst=asdf

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

source <(kubectl completion zsh)
source <(helm completion zsh)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/frederiknjs/bin/vault vault

alias ssh="TERM=xterm-256color ssh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(thefuck --alias)
