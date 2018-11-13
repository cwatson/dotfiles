# .bash_functions

function fpdf() {    # Find and open a PDF; best used after "ff" to narrow down results
    find . -type f -iname '*'$*'*'.pdf -exec xpdf {} \;
}

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

dcmseries() {   # Display series name based on 1st image of DICOM set
    dcmdump +P SeriesDescription $(ls ${1}* | head -1)
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

Rhelp() {
    echo "?${1}" | Rscript -
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

# Freesurfer-related functions
function viewsurf() {
    freeview -f ${1}/surf/${2}.pial:annot=aparc.DKTatlas40:name=${2}.pial:visible=1 \
        ${1}/surf/${2}.inflated:annot=aparc.DKTatlas40:name=inflated_thickness:visible=0
}

function viewseg() {
    #tkmedit ${1} brainmask.mgz lh.white -aux wm.mgz -aux-surface rh.white -seg aseg.mgz
    freeview -recon ${1}
}

function viewparc() {
    tkmedit ${1} brainmask.mgz lh.white -aux wm.mgz -aux-surface rh.white -seg aparc\+aseg.mgz
}

function viewLGI() {
    freeview -f ${1}/surf/${2}.pial:overlay=${2}.pial_lgi:overlay_threshold=1.5,4
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;36m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;35m") \
            man "$@"
}

