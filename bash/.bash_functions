# .bash_functions

todos() {
    clear
    cd /home/cwatson/Dropbox/orgpyvim
    python -m orgpyvim "$@"
    cd - > /dev/null
}

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

my_ip() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

# Improve the printing of ${PATH} variables {{{
ls_paths() {
    if [[ $# == 0 ]]; then
        p=${PATH}
    else
        p=${*}
    fi
    tr : '\n' <<< ${p}
}

sort_paths() {
    ls_paths ${*} | sort
}
#}}}

# "grep" a string but exclude commented-out lines; works if searching multiple files
grepnc() {
    grep ${1} ${@:2} | grep -v ':.*#' | grep --color=always ${1}
}

# Keep only certain page numbers of a PDF {{{
pdfcut() {
    qpdf --pages $1 $2 -- $1 o.pdf
}
#}}}
# "find"-related shortcuts {{{
ff() {
    find . -type f -iname '*'$*'*' | grep --color=never -i "$*"
}

fl() {
    find . -type l -iname '*'$*'*'
}

fdir() {
    find . -type d -iname '*'$*'*'
}

fext() {
    find ${1} -type f -name '*\.'${2} ${@:3}
}

ffzath() {
    ff $* | xargs zathura
}

# Org-related {{{
# Find all "org" files, excluding duplicates (hard links)
orgfiles() {
    stat -c '%i %n' $(fext ~ org -not -path "*.cache*" -not -path "*.vim*" | sort -r) | \
        awk '!seen[$1]++' | cut -d ' ' -f 2- | sort
}

# Convert org to html
org2html() {
    emacs ${1} --batch -f org-export-as-html --kill
}
#}}}

# Find all git repositories excluding those in ".vim"
repos() {
    find ~ -type d -name .git -not -path "*.vim*" | xargs dirname | sed 's:/home/cwatson:.:' | sort
}
#}}}
# Count the number of files in a directory or recursively {{{
lswc() {
    ls $* | wc -l
}

ffwc() {
    ff $* | wc -l
}
#}}}
# System-related {{{
psgrep() {
    ps -fp $(pgrep -f $*)
}

# Disk usage, sorted in human-readable from high to low
dusort() {
    du -sh $* | sort -hr
}
#}}}

mp3info() {
    ffprobe ${1} 2>&1 | grep -A90 'Metadata:'
}
