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
alias lof='libreoffice5.0 --nologo'
alias mplayer='mplayer -zoom -stop-xscreensaver'
alias mplayerISO='mplayer dvd://1 -dvd-device'
alias mp3='cd /media/disk-1; /usr/java/jre1.6.0_17/bin/java -jar NW*' #for Sinead's Sony MP3 player
alias tux='cd /usr/local/tuxguitar/current; ./tuxguitar; cd -'
alias azureus='cd /usr/local/vuze; ./azureus &'
alias vuze='azureus'

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
if [ "x$DISPLAY" != "x" ]; then
    export HAS_256_COLORS=yes
    alias tmux="tmux -2"
    if [ "$TERM" = "xterm" ]; then
        export TERM=xterm-256color
    fi
    alias vim="vim --servername VIM"
    if [ "$TERM" == "xterm" ] || [ "$TERM" == "xterm-256color" ]; then
        tvim() {
            tmux -2 new-session "TERM=screen-256color vim --servername VIM $@" ;
        }
    else
        tvim() {
            tmux new-session "vim --servername VIM $@" ;
        }
    fi
else
    if [ "$TERM" == "xterm" ] || [ "$TERM" == "xterm-256color" ]; then
        export HAS_256_COLORS=yes
        alias tmux="tmux -2"
        tvim() {
            tmux -2 new-session "TERM=screen-256color vim $@" ;
        }
    else
        tvim() {
            tmux new-session "vim $@" ;
        }
    fi
fi
if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]; then
    export TERM=screen-256color
fi
