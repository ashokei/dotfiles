#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias x='exit'
alias _='sudo'
alias ,='clear && ls'
alias please='sudo `history -1 | cut -d" " -f3-`'
which lolcat >/dev/null && alias c='lolcat -f'
[ -e $HOME/bin ] && export PATH=$HOME/bin:$PATH

# Linux

# Exherbo options
if which cave >/dev/null; then
  CAVE_RESOLVE_OPTIONS='--complete --no-lazy'
  CAVE_RESOLVE_OPTIONS+=' --suggestions ignore'
  CAVE_RESOLVE_OPTIONS+=' --continue-on-failure if-independent'
  export CAVE_RESOLVE_OPTIONS
  alias ca='time sudo cave'
  alias cr='ca resolve'
  alias crx='cr -x'
  alias cs='ca search'
  alias cS='ca show'
  alias csy='ca sync'

  # cave option add <package> <option>
  coa () {
    echo "*/$1 $2" | sudo tee -a /etc/paludis/options.conf
  }

  zebrapig () {
    if [[ -z "$(git rev-parse --git-dir 2>/dev/null)" ]]; then
      printf "error: not a git repository\n" && return 1
    fi
    zebrapig_repo=$(basename "$(git rev-parse --show-toplevel)")
    zebrapig_url=$(git format-patch -M -C -C -1 "${@:-HEAD}" --stdout | ix)
    zebrapig_desc=$(git log -n 1 --pretty=format:'%s' "${@:-HEAD}")
    zebrapig_cmd='!'"pq $zebrapig_url ::$zebrapig_repo $zebrapig_desc"
    printf '%s\n' "$zebrapig_cmd"
    if which xclip 2>&1 1>&-; then
        printf '%s' "$zebrapig_cmd" | xclip -in -selection clipboard
    fi
  }
fi

if which xclip >/dev/null; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

if [ `uname` == "Linux" ]; then
  alias modls="ls -R /lib/modules/`uname -r`/kernel/ | grep ko | cut -d'.' -f1"

  export EDITOR="vim"
  export VISUAL="vim"
  alias open='xdg-open'

  export XDG_DESKTOP_DIR="$HOME"
  export XDG_CONFIG_HOME=${HOME}/.config
  unalias rm 2> /dev/null
fi

# Function to switch and save the current path
function cd() {
  builtin cd "$@";
  echo "$PWD" >! ~/.cwd;
}
export cd
function cwd() {
  cd "$(cat ~/.cwd)"
}
if [ $(ps ax | grep [u]rxvt | grep -v weechat | wc -l) -gt 1 ]; then
  cwd
fi

alias vim='nvim'

function yolo() {
  cat "$@"
  sudo rm -rf "$@"
}
