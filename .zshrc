### alias
alias ll="ls -lah -G"
alias df="df -h"
alias grep="grep --color"
alias cp="cp -p"
alias rm="rm -i"
alias mv="mv -i"
alias man="man"
alias hg="history | grep"
alias gs="git status"
alias gl="git log --oneline | head"
alias gb="git branch"
alias gc="git checkout"
alias dps="docker ps -a"
alias gcam="git commit -a -m"


### zplug
source ~/.zplug/init.zsh
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug check || zplug install
zplug load


### 色付けで色の名前が使えたりとか
autoload -Uz add-zsh-hook
autoload -U colors && colors


### vcs_info の設定
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' formats '(%s)[%b] '
zstyle ':vcs_info:*' actionformats '(%s)[%b|%a] '
zstyle ':vcs_info:svn:*' branchformat '%b:r%r'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"

    [[ -t 1 ]] || return
    [ $EMACS ] && return
    case $TERM in
      *xterm*|rxvt|(dt|k|E)term)
      print -Pn "\e]2;localhost\a"
      ;;
    esac
}
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '(%s)[%b]%c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)[%b|%a]%c%u'
fi
function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
zstyle ':vcs_info:bzr:*' use-simple true

function toon {
  echo -n ""
}

### history 設定
HISTFILE=~/.zsh_historyx
HISTSIZE=10000
SAVEHIST=10000

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

### 補完
autoload -U compinit; compinit -C


