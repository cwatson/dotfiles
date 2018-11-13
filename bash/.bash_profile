# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export http_proxy=http://proxy.tch.harvard.edu:3128
export HTTP_PROXY=http://proxy.tch.harvard.edu:3128

# FreeSurfer stuff
export FREESURFER_HOME=/parietal/freesurfer/current
. ${FREESURFER_HOME}/SetUpFreeSurfer.sh
echo ''
echo "Current Subject Directory is: $SUBJECTS_DIR"
echo ''
QA_TOOLS=/parietal/freesurfer/QAtools_v1.1/

COMPILE_GPU=1
CUDA=/usr/local/cuda/current
CUDA_INSTALL_PATH=${CUDA}
FSLDIR=/parietal/fsl/current
FSLDEVDIR=${FSLDIR}
. ${FSLDIR}/etc/fslconf/fsl.sh
LD_LIBRARY_PATH=${CUDA}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
LD_LIBRARY_PATH=/usr/lib:/usr/lib64:${FSLDIR}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
PATH=${CUDA_INSTALL_PATH}/bin${PATH:+:${PATH}}

# Local dir's
#-------------------------------------------------------------------------------
tofdir=/raid2/fmri5/tof-tga/
fontandir=/raid2/fmri8/fontan
ccfadir=/raid2/fmri8/ibd/ccfa

PATH=$HOME/Dropbox/mri_library/bin:$HOME/Dropbox/dnl_library/bin:$HOME/Dropbox/bin/bash${PATH:+:${PATH}}
PATH=$PATH:/parietal/dnl_library/bin/experiments/:/parietal/dnl_library/bin/anonymization
PATH=$HOME/Dropbox/dnl_library/bin/fsl:${FSLDIR}/bin${PATH:+:${PATH}}
PATH=$PATH:/raid1/apps/dcmtk/dcmtk-3.5.4/bin:/raid1/apps/mricro/current:/parietal/mricrogl_lx64
EDITOR=/usr/local/bin/vim

export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

export QA_TOOLS COMPILE_GPU CUDA CUDA_INSTALL_PATH LD_LIBRARY_PATH
export PATH EDITOR DCMDICTPATH tofdir fontandir ccfadir FSLDEVDIR FSLDIR
unset USERNAME
