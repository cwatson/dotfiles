# .bash_functions

# Shortcut to print org-agenda
# The ugly hack w/ "pushd" is to keep the original $OLDPWD
todos() {
    clear
    pushd ${OLDPWD} > /dev/null 2>&1
    pushd ${OLDPWD} > /dev/null 2>&1
    pushd /home/cwatson/Dropbox/orgpyvim > /dev/null 2>&1
    python -m orgpyvim "$@"
    popd > /dev/null 2>&1
    popd > /dev/null 2>&1
    popd > /dev/null 2>&1
}

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

my_ip() {
    dig @resolver1.opendns.com ANY myip.opendns.com +short -4
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

# Merge and subset PDF files {{{
pdfcut() {
    qpdf --pages $1 $2 -- $1 o.pdf
}

pdfmerge() {
    qpdf --empty --pages $1 $2 -- o.pdf
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

# Find files with a specific extension
#
# $1    - the path to search
# $2    - the extension
# $3-$n - other arguments to `find`
#
# Examples
#
#    fext /home/cwatson org -not -path "*.cache*"

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
    proc=$(pgrep -f $*)
    if [[ $? -eq 0 ]]; then
        ps -fp ${proc}
    fi
}

# Disk usage, sorted in human-readable from high to low
dusort() {
    du -sh "$@" | sort -hr
}
#}}}

mp3info() {
    ffprobe -hide_banner "${1}" 2>&1 | grep -A90 'Metadata:'
}
