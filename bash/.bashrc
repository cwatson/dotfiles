# .bashrc

# Source global definitions
[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

# User specific aliases and functions
alias vi='/usr/local/bin/vim'
alias vim='vim --servername VIM'
alias ls='ls --color=auto'
alias ll="ls -l --time-style '+%F %T'"
alias la="ls -a"
alias ssh='ssh -Y'
alias df='df -h'
alias free='free -m'
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias less='less -R'
alias mkdir='mkdir -p'
alias tree='tree -C'
alias todos='python ~/Dropbox/bin/python/list_todo.py -d'
alias import='import +repage'
alias pdflatex='pdflatex -interaction nonstopmode'
alias cats='highlight -O ansi --force'

# Aliases for launching some external applications
alias winepdf='wine /home/cwatson/.wine/drive_c/Program\ Files/Tracker\ Software/PDF\ Viewer/PDFXCview.exe'
alias windjview='wine /home/cwatson/.wine/drive_c/Program\ Files\ \(x86\)/WinDjView/WinDjView.exe'
alias matlab='matlab -nosplash -nodesktop'
alias lof=

set -o vi

prompt() {
    local WHITE="\[\033[1;37m\]"
    local GREEN="\[\033[01;32m\]"
    local CYAN="\[\033[01;36m\]"
    local GRAY="\[\033[0;37m\]"
    local BLUE="\[\033[01;34m\]"
    local RED="\[\033[01;31m\]"
    BRANCH=' \033[00;33m\]$(git_branch)\[\033[00m\]'
    export PS1="$GRAY[$GREEN\u$CYAN@$BLUE\h $CYAN\W$GRAY$BRANCH]$ "
}
prompt

HISTSIZE=10000
HISTFILESIZE=10000

umask 002
