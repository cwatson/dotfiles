# .bash_profile

# Get the aliases and functions
[[ -f ~/.bashrc ]] && . ~/.bashrc

# User specific environment and startup programs

# FreeSurfer stuff
export FREESURFER_HOME=/usr/local/freesurfer/current
. ${FREESURFER_HOME}/SetUpFreeSurfer.sh
echo ''
echo "Current Subject Directory is: $SUBJECTS_DIR"
echo ''

FSLDIR=/usr/local/fsl/current
#. ${FSLDIR}/etc/fslconf/fsl.sh
LD_LIBRARY_PATH=/usr/lib:/usr/lib64:${FSLDIR}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/matlab/MATLAB_Runtime_2018a/v94/runtime/glnxa64:/usr/local/matlab/MATLAB_Runtime_2018a/v94/bin/glnxa64:/usr/local/matlab/MATLAB_Runtime_2018a/v94/sys/os/glnxa64:/usr/local/matlab/MATLAB_Runtime_2018a/v94/extern/bin/glnxa64 #${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/f5/vpn/lib/ # for "epsxe_x64" to work

PATH=$HOME/Dropbox/mri_library/bin:$HOME/Dropbox/dnl_library/bin:$HOME/Dropbox/bin/bash${PATH:+:${PATH}}
PATH=$HOME/Dropbox/dnl_library/bin/fsl:${FSLDIR}/bin${PATH:+:${PATH}}
PATH=/usr/local/texlive/2019/bin/x86_64-linux:${PATH}
PATH=${PATH}:${HOME}/.local/bin
MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:${MANPATH}
INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:${INFOPATH}
EDITOR=/usr/local/bin/vim
tbidir=${HOME}/Desktop/TBI/stress_study/
GOPATH=${HOME}/go

export PATH MANPATH INFOPATH LD_LIBRARY_PATH FSLDIR EDITOR GOPATH
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
