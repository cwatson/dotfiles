# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

# FreeSurfer stuff
export FREESURFER_HOME=/usr/local/freesurfer/current
. ${FREESURFER_HOME}/SetUpFreeSurfer.sh
echo ''
echo "Current Subject Directory is: $SUBJECTS_DIR"
echo ''

FSLDIR=/usr/local/fsl/current
. ${FSLDIR}/etc/fslconf/fsl.sh
LD_LIBRARY_PATH=/usr/lib:/usr/lib64:${FSLDIR}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

PATH=$HOME/Dropbox/mri_library/bin:$HOME/Dropbox/dnl_library/bin:$HOME/Dropbox/bin/bash${PATH:+:${PATH}}
PATH=$HOME/Dropbox/dnl_library/bin/fsl:${FSLDIR}/bin${PATH:+:${PATH}}
EDITOR=/usr/local/bin/vim
tbidir=${HOME}/Desktop/TBI/stress_study

export PATH LD_LIBRARY_PATH FSLDIR EDITOR
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
