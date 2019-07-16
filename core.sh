#!/bin/bash
# adds stages and pushes files in directory
SITE_SRC=$HOME/proj/chenla/core-docs
SITE_BUILD=$HOME/proj/chenla/core-html

# make sure the script is in the path
export PATH=$PATH:/home/deerpig/bin/ ;

# change to build dir and fetch any changes from
# any deployment from other boxes
cd $SITE_BUILD && \
git pull deploy master && \

# Change to the src directory and build the site
# using org-publish or jekyll build
cd $SITE_SRC && \

# Uncomment if this is a org publish site
# All projects will be published
/usr/local/bin/emacs --batch -l ~/.emacs -f org-publish-all && \
# Uncomment if this is a Jekyll site
#jekyll build  && \

# Change back to the build dir and push to the server
cd $SITE_BUILD && \
git add . && \
git add -u && \
git commit -m "deploy" && \
git push deploy master
exit
