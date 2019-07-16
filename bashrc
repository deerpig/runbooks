# .bashrc

# User specific aliases and functions


LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local 
export LD_LIBRARY_PATH

PYTHONPATH=/usr/local/lib/python2.7/site-packages/
export PYTHONPATH

# Directory Colors
eval `dircolors /home/deerpig/.dir_colors`

# Disable options:
shopt -u mailwarn
unset MAILCHECK   # I don't want my shell to warn me of incoming mail

# UTC Date string

alias utc='date --utc +%Y%m%d%H%M%S%N'

## load xmodmap
if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

## Ansible Config file
ANSIBLE_CONFIG=/home/deerpig/proj/playbooks/ansible.cfg
export ANSIBLE_CONFIG

# Web dev stuff

# Switch ownership of everything in /var/www/html/ 

alias chweb='sudo chown -R deerpig /var/www/html/'
alias unweb='sudo chown -R root /var/www/html/'
alias qmacs='emacs -nw -q --load ~/.emacs.d/minmacs.el'

# remove git lock files
alias fd='find ~/proj/ -type f -name *.lock -delete'

# The 'ls' family (this assumes you use the GNU ls)
alias ll="ls -Al"           # show list
alias la='ls -Al'           # show hidden files
alias lx='ls -lXB'          # sort by extension
alias lk='ls -lSr'          # sort by size
alias lc='ls -lcr'	    # sort by change time  
alias lu='ls -lur'	    # sort by access time   
alias lt='ls -ltr'          # sort by date
alias lm='ls -al | more'    # pipe through 'more'
alias tree='tree -Csu'      # nice alternative to 'ls'
alias ls='ls -hF --color'   # add colors for filetype recognition
# alias lr='ls -lR'         # recursive ls

#sometimes more IS less
alias more='less'

export PAGER=most

alias ..='cd ..'

alias genburs=/home/deerpig/bin/genburrs.sh
alias genburrs=/home/deerpig/bin/genburrs.sh
alias ins='sudo yum -y install'
alias disk2='cd /disk2/Media/Pictures/Update-Packs/update-torrents/'
alias desk='cd ~/Desktop'
alias web='cd /var/www/html/'

alias bit='screen bittorrent-curses'
alias start='sudo /etc/init.d/'
alias wire='sudo /usr/sbin/wlassistant'
alias rtail='sudo ./root-tail.sh'
alias elot='sudo echolot -i eth0 -I "my-computers" -d "/home/deerpig/trusted.mac"'
alias kfire='pkill firefox'
alias ff='/home/deerpig/bin/firefox/firefox'

alias untar='tar -zxvf'

#spelling/typos

alias mroe=more


# Aliases for ssh'in into remote servers 
alias chenla='ssh deerpig@chenla.la'
alias godown='ssh deerpig@godown.sg'
alias ling='ssh deerpig@192.168.1.5'


EDITOR='/usr/bin/emacsclient'

export MOST_EDITOR='(file=%s; line=d%; /usr/bin/emacsclient -t +$line $file -a zile +$line)'

#turn on settings
shopt -s cdspell
shopt -s dotglob
export HISTCONTROL=ignoreboth


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


#-----------------------
# Greeting, motd etc...
#-----------------------

# Define some colors first:
#red='\e[0;31m'
#RED='\e[1;31m'
#blue='\e[0;34m'
#BLUE='\e[1;34m'
#cyan='\e[0;36m'
#CYAN='\e[1;36m'
#NC='\e[0m'              # No Color
# --> Nice. Has the same effect as using "ansi.sys" in DOS.

# Looks best on a black background.....
#echo -e "${CYAN}This is BASH ${RED}${BASH_VERSION%.*}\
#${CYAN} - DISPLAY on ${RED}$DISPLAY${NC}\n"
# date
# if [ -x /usr/bin/fortune ]; then
#     /usr/bin/fortune -s     # makes our day a bit more fun.... :-)
# fi

# function _exit()	# function to run upon exit of shell
# {
#     echo -e "${RED}Hasta la vista, baby${NC}"
# }
# trap _exit EXIT

#-----------------------------------
# Process/system related functions:
#-----------------------------------

function my_ps()
{ ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

function pp()
{ my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

function my_ip() # get IP adresses
{
    MY_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | \
sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | \
sed -e s/P-t-P://)
}

function ii()   # get current host related info
{
  echo -e "\nYou are logged on ${RED}$HOST"
  echo -e "\nAdditionnal information:$NC " ; uname -a
  echo -e "\n${RED}Users logged on:$NC " ; w -h
  echo -e "\n${RED}Current date :$NC " ; date
  echo -e "\n${RED}Machine stats :$NC " ; uptime
  echo -e "\n${RED}Memory stats :$NC " ; free
  my_ip 2>&- ;
  echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
  echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
  echo
}

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi



export WORKON_HOME=${HOME}/proj/lala
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
elif [ -f /usr/bin/virtualenvwrapper.sh ]; then
   source /usr/bin/virtualenvwrapper.sh
fi


# Configure Colors:     
COLOR_WHITE='\033[1;37m'
COLOR_LIGHTGRAY='033[0;37m'
COLOR_GRAY='\033[1;30m'
COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_LIGHTRED='\033[1;31m'
COLOR_GREEN='\033[0;32m'
COLOR_LIGHTGREEN='\033[1;32m'
COLOR_BROWN='\033[0;33m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_LIGHTBLUE='\033[1;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_PINK='\033[1;35m'
COLOR_CYAN='\033[0;36m'
COLOR_LIGHTCYAN='\033[1;36m'
COLOR_DEFAULT='\033[0m'

# used on uron desktop
# PS1="\[\e[1;33m\]╭ \[\e[1;34m\]\u\[\e[1;32m\]@\H:\[\e[1;33m\]\w\n╰ $ \[\033[0m\]"
# Use a different host color for different server groups:
#  - local     lightgreen
#  - pnca      white
#  - chenla    pink
#  - customers lightcyan

PS1="\[$COLOR_YELLOW\]╭ \[$COLOR_LIGHTBLUE\]\u\[$COLOR_LIGHTGREEN\]@\H:\[$COLOR_YELLOW\]\w\n╰ $ \[\033[0m\]"

# added by Miniconda3 installer
export PATH="/home/deerpig/miniconda3/bin:$PATH"
