#!/bin/bash
# Mirror directories
#MIRROR_DOT=/media/deerpig/Transcend/repos/dot
#MIRROR_ORG=/media/deerpig/Transcend/repos/org
DOT=~/.dotfiles
ORG=~/org
# make sure the script is in the path
export PATH=$PATH:/home/deerpig/bin/ ;

# change to build dir and fetch any changes from
# any deployment from other boxes
cd $DOT && \
git push backup && \
    
cd $ORG && \
git push backup && 

exit
