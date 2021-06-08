echo "Welcome $USER"

# Configuration for prompt
  autoload -Uz colors && colors
  autoload -Uz compinit
  compinit
  PROMPT="%{$fg[blue]%}% mac %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%# "
  RPROMPT="[%{$fg_no_bold[yellow]%}%T%{$reset_color%}]"

# Add colors to ls
  alias 'ls=ls -G'

# Play safe!
  alias 'rm=rm -i'
  alias 'mv=mv -i'
  alias 'cp=cp -i'

# Change modes faster (can change behaviour of other commans, default 4)
  export KEYTIMEOUT=1

# Git
  alias 'gk=z gitk --all'
  alias 'gs=git status'
  alias 'gd=git diff'
  alias 'gg=z git gui'
  alias 'git-stashpullpop=git stash && git pull --rebase && git stash pop'
  alias 'gl=git log --graph --abbrev-commit --pretty=oneline --decorate'

# Set VIM as default editor
  bindkey -v
  export VISUAL=vim
  export EDITOR="$VISUAL"

# Use vim cli mode
  bindkey '^P' up-history
  bindkey '^N' down-history

# ctrl-r starts searching history backward
  bindkey '^r' history-incremental-search-backward

# History configuration:
# set history size
  export HISTSIZE=10000
# save history after logout
  export SAVEHIST=10000
# history file
  export HISTFILE=~/.zhistory
# append into history file
  setopt INC_APPEND_HISTORY
# save only one command if 2 common are same and consistent
  setopt HIST_IGNORE_DUPS
# add timestamp for each entry
  setopt EXTENDED_HISTORY

for f in zshaliases zshfunc zshrclocal; do
    if [[ -f ~/localdotfiles/$f ]]; then
        source ~/localdotfiles/$f
    fi
    if [[ -f ~/dotfiles/$f ]] ; then
        source ~/dotfiles/$f
    fi
done
