# .bash_functions

git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

my_ip() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

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

# "grep" a string but exclude commented-out lines; works if searching multiple files
grepnc() {
    grep ${1} ${@:2} | grep -v ':.*#'
}

ff() {
    find . -type f -iname '*'$*'*' | grep --color=never -i "$*"
}

fl() {
    find . -type l -iname '*'$*'*'
}

fdir() {
    find . -type d -iname '*'$*'*'
}

psgrep() {
    ps -fp $(pgrep -f $*)
}

lswc() {
    ls $* | wc -l
}

ffwc() {
    ff $* | wc -l
}

# Disk usage, sorted in human-readable from high to low
dusort() {
    du -sh $* | sort -hr
}
