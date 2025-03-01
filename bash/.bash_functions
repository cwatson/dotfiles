# .bash_functions

# Shortcut to print org-agenda
# The ugly hack w/ "pushd" is to keep the original $OLDPWD
todos() {
    clear
    pushd ${OLDPWD} > /dev/null 2>&1
    pushd ${OLDPWD} > /dev/null 2>&1
    pushd /home/cwatson/Dropbox/orgpy > /dev/null 2>&1
    python3 -m orgpy "$@"
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
#
# $1 - the file to process
# $2 - the pages to include (e.g., 2-250)
pdfcut() {
    qpdf --pages "$1" $2 -- "$1" o.pdf
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

# Multimedia {{{
# mp3 {{{
mp3info() {
    ffprobe -hide_banner "${1}" 2>&1 | grep -A90 'Metadata:'
}

# Delete tags w/ junk in them
delete_id3v1() {
    mid3v2 -s "$@"
    mid3v2 --delete-frames='TIT1,COMM,TENC,TPUB,TXXX,WXXX,PRIV' "$@"
}

mp3artist() {
    #id3info "$@" | grep -E 'TPE1|TP1' | cut -d: -f2-
    mid3v2 -l "$@" | grep -E 'TPE1|TP1' | cut -d= -f2-
}

mp3album() {
    #id3info "$@" | grep -E '\<TALB\>|\<TAL\>' | cut -d: -f2-
    mid3v2 -l "$@" | grep -E '\<TALB\>|\<TAL\>' | cut -d= -f2-
}

mp3title() {
    #id3info "$@" | grep -E 'TIT2|TIT' | cut -d: -f2-
    mid3v2 -l "$@" | grep -E 'TIT2|TIT' | cut -d= -f2-
}

mp3titlelen() {
    title=$(mp3title "${1}" | sed 's/^\s//')
    echo ${#title}
}

mp3track() {
    #id3info "$@" | grep -E 'TRCK|TRK' | cut -d: -f2-
    mid3v2 -l "$@" | grep -E 'TRCK|TRK' | cut -d= -f2-
}

mp3year() {
    #id3info "$@" | grep -E 'TYER' | cut -d: -f2-
    mid3v2 -l "$@" | grep -E 'TDRC|TYER' | cut -d= -f2-
}

mp3genre() {
    mid3v2 -l "$@" | grep -E 'TCON' | cut -d= -f2-
}

# Shorten strings that are longer than 30 characters
#
# $1    - the filename
# $2    - the file's extension
shorten() {
    if (( ${#1} > 30 )); then
        out=$(echo "$(basename "${1}" ."${2}" | cut -c1-23)....mp3")
    else
        out="${1}"
    fi
    echo "${out}"
}

mp3tags() {
    #titlelens=$(for f in "$@"; do mp3titlelen "${f}"; done)
    short=$(for f in "$@"; do shorten "${f}" mp3; done)
    paste <(echo -e "Filename\n${short}" | sed 's/mp3\s/mp3\n/g') \
        <(echo -e "Year\n$(mp3year "$@")" | sed 's/^\s//') \
        <(echo -e "Artist\n$(mp3artist "$@")" | sed 's/^\s//') \
        <(echo -e "Album\n$(mp3album "$@")" | sed 's/^\s//') \
        <(echo -e "Track\n$(mp3track "$@")" | sed 's/^\s//') \
        <(echo -e "Title\n$(mp3title "$@")" | sed 's/^\s//') \
        <(echo -e "Genre\n$(mp3genre "$@")") | \
            column -ts $'\t' -o $'\t'
}

mp3sort() {
    mp3tags "${@:2}" | sort -t$'\t' -k${1}
}
#}}}
# flac {{{
flacyear() {
    metaflac --show-tag=DATE "$@" | cut -d= -f2-
}

flacartist() {
    metaflac --show-tag=ARTIST "$@" | cut -d= -f2-
}

flacalbum() {
    metaflac --show-tag=ALBUM "$@" | cut -d= -f2-
}

flactrack() {
    metaflac --show-tag=TRACKNUMBER "$@" | cut -d= -f2-
}

flactitle() {
    metaflac --show-tag=TITLE "$@" | cut -d= -f2-
}

flacgenre() {
    metaflac --show-tag=GENRE "$@" | cut -d= -f2-
}

flactags() {
    short=$(for f in "$@"; do shorten "${f}" flac; done)
    paste <(echo -e "Filename\n${short}" | sed 's/flac\s/flac\n/g') \
        <(echo -e "Year\n$(flacyear "$@")" | sed 's/^\s//') \
        <(echo -e "Artist\n$(flacartist "$@")" | sed 's/^\s//') \
        <(echo -e "Album\n$(flacalbum "$@")" | sed 's/^\s//') \
        <(echo -e "Track\n$(flactrack "$@")" | sed 's/^\s//') \
        <(echo -e "Title\n$(flactitle "$@")" | sed 's/^\s//') \
        <(echo -e "Genre\n$(flacgenre "$@")") | \
            column -ts $'\t' -o $'\t'
        #<(echo -e "Title len.\n${titlelens}") | \
}
#}}}
# MKV file stuff {{{
mkvsubs() {
    mkvmerge -J "${1}" | jq -r '[.tracks[] | select(.type == "subtitles")] | .[] as $result | [$result.id, $result.properties.language, $result.properties.track_name] | @csv'
}

mkvaudio() {
    mkvmerge -J "${1}" | jq -r '[.tracks[] | select(.type == "audio")] | .[] as $result | [$result.id, $result.properties.language, $result.properties.track_name] | @csv'
}
#}}}

video_duration() {
    ffmpeg -i "${1}" 2>&1 | grep "Duration"| cut -d ' ' -f 4 | sed s/,//
}

# Math book information {{{
booktitle() {
    awk -F'_-_' '{print $2}' <(echo "${1}") | sed 's/\([A-Z]\)/ \1/g' | sed 's/I\sI/II/' | sed 's/I\sI/II/' | sed 's/S\sA\sS/SAS/' | sed 's/_/:/' | sed 's/^\s//'
}

booktitlelen() {
    title=$(booktitle "${1}" | sed 's/^\s//')
    echo ${#title}
}

bookauth() {
    auths=${1##*/}
    awk -F'_-_' '{print $1}' <(echo "${auths}") | sed 's/_/, /g' | sed 's/^,\s//' | sed 's/,$//'
}

bookedition() {
    awk -F'_-_' '{print $3}' <(echo "${1}") | sed 's/Ed/ Ed/g'
}

bookyears() {
    awk -F'_-_' '{print $4}' <(echo "${1}")
}

bookpubs() {
    awk -F'_-_' '{print $5}' <(echo "${1}")
}

#TODO list page count as well? Using "pdfinfo FOO | grep Pages | awk '{print $2}'"
num_pages() {
    ext=${1##*.}
    if [ $ext == djvu ]; then
        djvused -e n "${1}"
    else
        pdfinfo "${1}" 2> /dev/null | grep Pages | awk '{print $2}'
    fi
}

# How to sort output: (e.g., by year)
#     bookinfo *.{pdf,djvu} | sort -t$'\t' -k4
bookinfo() {
    authors=$(for f in "$@"; do bookauth "${f}"; done)
    titles=$(for f in "$@"; do booktitle "${f}"; done)
    editions=$(for f in "$@"; do bookedition "${f}"; done)
    years=$(for f in "$@"; do bookyears "${f}"; done)
    publishers=$(for f in "$@"; do ext=${f##*.}; bookpubs $(basename "${f}" .${ext}); done)
    numpages=$(for f in "$@"; do num_pages "${f}"; done)
    paste <(echo -e "Author(s)\n${authors}" | sed 's/^\s//') \
        <(echo -e "Title\n${titles}") \
        <(echo -e "Edition\n${editions}") \
        <(echo -e "Year\n${years}") \
        <(echo -e "Publisher\n${publishers}") \
        <(echo -e "Num. Pages\n${numpages}") |
            column -ts $'\t' -o $'\t'
}

# First argument is the column number
booksort() {
    bookinfo "${@:2}" | sort -t$'\t' -k${1}
}

# To be used in the 'book_series' directory
count_books() {
    for d in "$@"; do
        echo -ne "${d}:\t"
        ls "${d}" | wc -l
    done |
    column -t | sort -k2 -hr
}
#}}}
