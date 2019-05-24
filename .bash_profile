export GOPATH=~/go
export PATH=${PATH}:${GOPATH//://bin:}/bin

export CSCOPE_EDITOR=`which emacs`

export WORKON_HOME=~/env
if [ ! -f $WORKON_HOME ]; then
	mkdir -p $WORKON_HOME
fi

export PROJECT_HOME=/
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

# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH


