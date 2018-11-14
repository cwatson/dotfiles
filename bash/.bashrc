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
alias music='sshfs cwatson.ddns.net: /mnt/cwatson'
alias tree='tree -C'
alias todos='python ~/Dropbox/bin/python/list_todo.py -d'
alias import='import +repage'
alias pdflatex='pdflatex -interaction nonstopmode'
alias cats='highlight -O ansi --force'

# Rsync books, journal, classes, Metal, New_Folder, USB
alias rsyncB='rsync -avh --del --progress ~/Desktop/books/ cwatson.ddns.net:Desktop/books'
alias rsyncJ='rsync -avh --del --progress cwatson.ddns.net:Desktop/journal/ ~/Desktop/journal'
alias rsyncU='rsync -avh --del --exclude=CHB/cardiac/fontan/dti/PROBTRACKX2/ --exclude=CHB/cardiac/fontan/dti/NBS_test/ --exclude=lost\+found --progress /media/patriot/ cwatson.ddns.net:Desktop/usb_backup'
alias rsyncC='rsync -avh --del --progress ~/Desktop/classes/ cwatson.ddns.net:Desktop/classes'
alias rsyncM='rsync -avh --del --progress ~/Desktop/Music/ cwatson.ddns.net:Desktop/Music'
alias rsyncN='rsync -avh --del --progress ~/New_Folder/ cwatson.ddns.net:New_Folder'
alias rsyncW='rsync -avh --del --progress /media/patriot/ cwatson.ddns.net:Desktop/usb_backup'
alias unisonP='unison -ui text /media/patriot/CHB/cardiac/fontan/data/Fontan/ ssh://parietal.tch.harvard.edu//raid2/fmri8/fontan/data/Fontan'
alias unisonH='unison -ui text /media/patriot/CHB/cardiac/fontan/data/Fontan/ ssh://cwatson.ddns.net//home/cwatson/Desktop/usb_backup/CHB/cardiac/fontan/data/Fontan'

# Aliases for launching some external applications
alias winepdf='wine /home/cwatson/.wine/drive_c/Program\ Files/Tracker\ Software/PDF\ Viewer/PDFXCview.exe'
alias windjview='wine /home/cwatson/.wine/drive_c/Program\ Files\ \(x86\)/WinDjView/WinDjView.exe'
alias matlab='matlab -nosplash -nodesktop'
alias lof='libreoffice6.1 --nologo'
alias jabref='java -jar /home/cwatson/JabRef-3.8.2.jar'

# Aliases for connecting to the different TACC servers
alias stampede='tmux rename-session "TACC" && tmux set-option status off && ssh cgwatson@stampede.tacc.utexas.edu -t tmux'
alias stampede2='tmux rename-session "Stampede" && tmux set-option status off && ssh cgwatson@stampede2.tacc.utexas.edu -t tmux -2'
alias corral='tmux rename-session "Corral" && ssh cgwatson@corral.tacc.utexas.edu'
alias ranch='tmux rename-session "Ranch" && ssh cgwatson@ranch.tacc.utexas.edu'
alias lonestar='ssh cgwatson@ls5.tacc.utexas.edu' #'tmux rename-session "Lonestar" && tmux set-option status off && ssh cgwatson@ls5.tacc.utexas.edu -t tmux -2'

set -o vi
shopt -s direxpand  # Fix variable name expansion on tab complete

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

# Change the TERM environment variable (to get 256 colors) and make Vim
# connecting to X Server even if running in a terminal emulator (to get
# dynamic update of syntax highlight and Object Browser):
# Change the TERM environment variable (to get 256 colors) even if you are
# accessing your system through ssh and using either Tmux or GNU Screen:
if [ "$TERM" = "xterm" ] || [ "$TERM" = "xterm-256color" ]; then
    alias tmux='tmux -2'
    export TERM=xterm-256color
    export HAS_256_COLORS=yes
fi
if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]; then
    export TERM=screen-256color
fi
