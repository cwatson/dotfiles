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
alias vless='vim -u /usr/local/share/vim74/macros/less.vim'
alias music='sshfs cwatson.ddns.net: /mnt/cwatson'
alias tree='tree -C'
alias todos='python ~/Dropbox/bin/python/list_todo.py -d'
alias import='import +repage'
alias pdflatex='pdflatex -interaction nonstopmode'
alias rsyncJ='rsync -avh --del --progress cwatson.ddns.net:Desktop/journal/ ~/Desktop/journal'
alias rsyncU='rsync -avh --del --exclude=CHB/cardiac/fontan/dti/PROBTRACKX2/ --exclude=lost\+found --progress /media/patriot/ cwatson.ddns.net:Desktop/usb_backup'
alias briss='java -jar /usr/local/briss-0.9/briss-0.9.jar'
alias cats='highlight -O ansi --force'

# Aliases for launching some external applications
alias winepdf='wine /home/cwatson/.wine/drive_c/Program\ Files/Tracker\ Software/PDF\ Viewer/PDFXCview.exe'
alias windjview='wine /home/cwatson/.wine/drive_c/Program\ Files\ \(x86\)/WinDjView/WinDjView.exe'
alias matlab='matlab -nosplash -nodesktop'
alias lof='libreoffice5.0 --nologo'

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

# Lines added by the Vim-R-plugin command :RpluginConfig (2015-Jul-06 13:10):
# Change the TERM environment variable (to get 256 colors) and make Vim
# connecting to X Server even if running in a terminal emulator (to get
# dynamic update of syntax highlight and Object Browser):
if [ "x$DISPLAY" != "x" ]
then
    export HAS_256_COLORS=yes
    alias tmux="tmux -2"
    if [ "$TERM" = "xterm" ]
    then
        export TERM=xterm-256color
    fi
    alias vim="vim --servername VIM"
    if [ "$TERM" == "xterm" ] || [ "$TERM" == "xterm-256color" ]
    then
        function tvim()
        {
            tmux -2 new-session "TERM=screen-256color vim --servername VIM $@" ;
        }
    else
        function tvim()
        {
            tmux new-session "vim --servername VIM $@" ;
        }
    fi
else
    if [ "$TERM" == "xterm" ] || [ "$TERM" == "xterm-256color" ]
    then
        export HAS_256_COLORS=yes
        alias tmux="tmux -2"
        function tvim()
        {
            tmux -2 new-session "TERM=screen-256color vim $@" ;
        }
    else
        function tvim()
        {
            tmux new-session "vim $@" ;
        }
    fi
fi
if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]
then
    export TERM=screen-256color
fi
