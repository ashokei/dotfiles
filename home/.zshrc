bindkey -e

setopt autocd
setopt autopushd
setopt pushd_ignore_dups
setopt interactivecomments

autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic

source ~/.zplug/init.zsh

export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
zplugs=()
zplug "rimraf/k"                                              # better version of `ls`
zplug "andsens/homeshick", use:"homeshick.sh"                 # `homesick` dotfiles manager
zplug "sorin-ionescu/prezto", use:"modules/git/alias.zsh"     # sensible git aliases
zplug "sorin-ionescu/prezto", use:"modules/history/init.zsh"  # sensible history defaults
zplug "sorin-ionescu/prezto", use:"modules/homebrew/init.zsh" # sensible homebrew shortcuts
zplug "junegunn/fzf", hook-load: "source ~/.fzf.zsh"          # fuzzy finder, try ^R, ^T, and kill <tab>
zplug "zsh-users/zsh-autosuggestions"                         # suggest from history
zplug "zsh-users/zsh-syntax-highlighting"                     # commandline syntax highlighting
zplug "zsh-users/zsh-history-substring-search"                # partial fuzzy history search
export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡  '
zplug "djui/alias-tips"                                       # help remember aliases
export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
export PROMPT_GEOMETRY_GIT_TIME=false
zplug "frmendes/geometry"                                     # clean theme
zplug load

bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

function h help { man $@ }
function x { exit }
function s { rg $@ }
function o { open "${@:-'.'}" }
function a { atom "${@:-'.'}" }
function v { nvim $@ }
function c { lolcat $@ }
function _ { sudo $@ }
function , { clear && k }

function badge { printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$@" | base64) }
function twitch { livestreamer twitch.tv/$@ best }
function n { (($#)) && echo alias $1="'""$(fc -n1 -1)""'" >> ~/.zshrc && exec zsh } # n: create an alias
function t { (($#)) && echo -E - "$*" >> ~/todo.md || { test -f ~/todo.md && c $_ } }; t # t: add or display todo items

function up { # upgrade everything
  (( $+commands[homeshick] )) && homeshick pull
  (( $+commands[zplug] )) && zplug update
  (( $+commands[brew] )) && {
    brew update && \
    brew upgrade && \
    () { # brew upgrade --head --weekly
      last_week=`date -v -7d +%s`
      for pkg in `brew ls`; do
        install_date=`brew info $pkg | rg -N --replace '$1' "Built from source on ([-\d+]+).*"`
        if (( $install_date )); then
          install_date=`date -j -f %Y-%m-%d $install_date +%s`
          (( $last_week > $install_date )) && brew reinstall $pkg
        fi
      done
    }
    brew cleanup && \
    brew cask cleanup && \
    brew doctor
  }
}

function notify { # commandline notifications
  osascript -e "display notification \"$2\" with title \"$1\""
}

[[ -n $SSH_CLIENT ]] && { # remote pbcopy, pbpaste, notify
  for command in pb{copy,paste} notify; do
    (( $+commands[$command] )) && unfunction $command
    function $command {
      ssh `echo $SSH_CLIENT | awk '{print $1}'` "zsh -i -c \"$command $@\"";
    }
  done

  (( $+commands[dbaliases] )) && source $(dbaliases)
  (( $+commands[review] )) && r() { (( ! $# )) && echo "$0 reviewer [cc [cc...]]" || EDITOR=true review -g -r $1 ${2+-c "${(j.,.)@[2,-1]}"} }

  (( $+commands[try] )) && try() {
    local arg=$(echo $* | grep -oE 'ROD-[0-9]+')
    local log=$(git log -1 --oneline | grep -oE 'ROD-[0-9]+')

    [[ -n $log && -n $arg ]] && echo "[ERROR] Commit and command ticket found" && return -1
    [[ -n $log ]] && JIRA_PARAM=" --extra-param jira=$log"
    $commands[try] $* $JIRA_PARAM
  }

  alias p='~/development/Etsyweb/bin/dev_proxy'; alias pon='p on'; alias pof='p off'; alias prw='p rw'
}

cd ~/development/Etsyweb || cd ~/code/rustboy
