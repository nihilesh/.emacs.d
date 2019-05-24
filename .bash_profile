export GOPATH=~/go
export PATH=${PATH}:${GOPATH//://bin:}/bin

export CSCOPE_EDITOR=`which emacs`

export WORKON_HOME=~/env
if [ ! -f $WORKON_HOME ]; then
	mkdir -p $WORKON_HOME
fi
export PROJECT_HOME=$HOME/ws
export VIRTUALENVWRAPPER_WORKON_CD=1
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
source /usr/local/bin/virtualenvwrapper.sh

if [ -f ~/bin/git-completion.bash ]; then
  . ~/bin/git-completion.bash
fi

function pssh() {
   if [[ 2 -ne $# ]]; then
	echo "Usage: pssh <username> <host>"
	return
   fi;
   
   if [[ ! -e ~/.ssh/id_rsa.pub ]];  then 
      ssh-keygen -t rsa; 
   fi; 
   echo "Copying public certificate"
   ssh $1@$2 mkdir -p .ssh
   cat ~/.ssh/id_rsa.pub | ssh $1@$2 'cat >> .ssh/authorized_keys'
   echo "Setting permissions"
   ssh $1@$2 "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
   echo "alias $2='ssh $1@$2'" >> ~/.bash_profile
   source ~/.bash_profile
}

function sshtun(){
   myaddr=`ifconfig en0 | awk '/inet /{ print $2}'`
   if [[ 1 -ne $# ]]; then
      echo "Usage: $0 <port>"
      return
   fi;
   cmd="ssh -R $1:localhost:$1  ${USER}@${myaddr}"
   echo ${cmd}
   vagrant ssh -c "${cmd}"
}

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}
print_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(print_git_branch)\[\033[00m\] $ "

if [ -f ~/.bash_alias ]; then
   source ~/.bash_alias
fi

alias aos='workon leblon'
alias conc='workon concierge'
alias sys='workon systest'
alias vup='vagrant up'
alias vsh='vagrant ssh'
alias scli_update='docker pull docker-registry.dc1.apstra.com:5000/slicercli:latest'
alias scli='docker run -e PAGER=cat --rm -it -v $HOME:/root  -v $PWD:/project docker-registry.dc1.apstra.com:5000/slicercli /usr/local/bin/slicercli -i ' 
alias sclii='docker run --rm -t -v $HOME:/root -v $PWD:/project docker-registry.dc1.apstra.com:5000/slicercli /usr/local/bin/slicercli'
#alias dmongo='ssh -R 9000:172.17.0.15:27017 atul@127.0.0.1'
alias dslicer='ssh apstrktr@10.1.3.107'

alias mysqld='sudo /usr/local/mysql/support-files/mysql.server $1'

alias glog='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias gs='git status' 
alias gbr='git branch' 
alias gco='git checkout'
function grbi_f() { git fetch && git rebase -i origin/$1; }
alias grbi=grbi_f
alias grba='git status | egrep "both (added|modified)" | awk '\''{print $3}'\'' | xargs git add && git status'
alias grbc='git rebase --continue' 
alias gp='git push'
alias gpf='git push -f origin $(parse_git_branch)'


alias vi=vim
alias py='ipython --autoindent --automagic --pprint'
alias slicercli='PAGER=cat slicercli'
alias bs4='ssh apstrktr@bs4'
alias bs3='ssh apstrktr@bs3'
alias slicer='ssh apstrktr@slicer'
alias dirfiles='ssh apstrktr@dirfiles'
alias buildfiles='ssh apstrktr@buildfiles'
alias bs4='ssh apstrktr@bs4'
alias bs10='ssh apstrktr@bs10'
alias bs18='ssh apstrktr@bs18'
alias bs15='ssh apstrktr@bs15'
alias apstrktr='ssh bs13@apstrktr'
alias csrv='ssh apstrktr@10.4.10.111'
alias cslv='ssh apstrktr@10.4.10.112'
alias csrvd='ssh apstrktr@10.1.3.111'
alias cslvd='ssh apstrktr@10.1.3.112'
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.5.3-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java org.antlr.v4.gui.TestRig'
alias bs5='ssh apstrktr@bs5'
alias bs9='ssh apstrktr@bs9'
alias bs13='ssh apstrktr@bs13'
alias apstrktr='ssh bs14@apstrktr'
alias bs14='ssh apstrktr@bs14'
alias 10.1.2.32='ssh apstrktr@10.1.2.32'
alias bs23='ssh apstrktr@bs23'
alias bs28='ssh apstrktr@bs28.dc1.apstra.com'
alias bs22='ssh apstrktr@bs22'
alias apstrktr='ssh bs3@apstrktr'
alias bs32='ssh root@bs32'
alias bs26='ssh apstrktr@bs26'
alias bs25='ssh apstrktr@bs25'
alias bs28='ssh apstrktr@bs28'
alias admin='ssh bs27@admin'
alias bs27='ssh admin@bs27'
alias bs27='ssh apstrktr@bs27'
alias bs27='ssh apstrktr@bs27'
alias bs21='ssh apstrktr@bs21'
alias bs20='ssh apstrktr@bs20'

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
alias jenkins='ssh apstrktr@jenkins'
alias bs101-14r='ssh apstrktr@bs101-14r'
alias bs27='ssh apstrktr@bs27'
alias slicer-dev='ssh apstrktr@slicer-dev'

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
alias bs101-13l='ssh apstrktr@bs101-13l'
alias bs101-13l='ssh apstrktr@bs101-13l'
alias bs101-13l='ssh admin@bs101-13l'
alias bs101-13l='ssh apstrktr@bs101-13l'

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

source ~/.bashrc
alias 10.4.10.111='ssh apstrktr@10.4.10.111'
alias 10.4.10.112='ssh apstrktr@10.4.10.112'
alias conc-runner-dev='ssh apstrktr@conc-runner-dev'
alias concierge-dev='ssh apstrktr@concierge-dev'
