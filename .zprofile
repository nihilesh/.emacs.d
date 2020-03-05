PATH="${PATH}:/Users/atpatil/bin"

# Setting PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:/Users/atpatil/Library/Python/2.7/bin:${PATH}"
PATH="${PATH}:/Users/atpatil/Library/Python/2.7/bin"

# Setting PATH for GO
export GOPATH=~/go
export PATH=${PATH}:${GOPATH//://bin:}/bin

export PATH

export CSCOPE_EDITOR=`which emacs`

# Virtualenv
export WORKON_HOME=~/.virtenv
export VIRTUAL_ENV_DISABLE_PROMPT=1
source /Users/atpatil/Library/Python/2.7/bin/virtualenvwrapper.sh 

#fpath=(~/.zsh "${fpath[@]}")
#autoload -Uz virtualenv_info __git_ps1

if [ -f ~/.zsh/git-prompt.sh ]; then
   source ~/.zsh/git-prompt.sh
fi
if [ -f ~/.zsh/virtualenv-prompt.sh ]; then
   source ~/.zsh/virtualenv-prompt.sh
fi

setopt PROMPT_SUBST ; PS1='$(virtualenv_info "%s ")%n@%m %~ $(__git_ps1 "(%s)")\$ '

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
   echo "alias $2='ssh $1@$2'" >> ~/.zpofile
   source ~/.zprofile
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

if [ -f ~/.bash_alias ]; then
   source ~/.bash_alias
fi

if [ -f ~/.git_alias ]; then
   source ~/.git_alias
fi

alias buildfiles='ssh apstrktr@buildfiles'
alias concierge='ssh apstrktr@concierge.dc1.apstra.com'
alias conc-runner-vcenter='ssh apstrktr@conc-runner-vcenter'
alias concierge-dev.dc1.apstra.com='ssh apstrktr@concierge-dev.dc1.apstra.com'
alias aos-1='ssh admin@aos-1'
alias concierge-dev='ssh apstrktr@concierge-dev'
alias kube-jenkins-slave='ssh apstrktr@kube-jenkins-slave'
alias slicer-dev='ssh apstrktr@slicer-dev'
alias bs28='ssh admin@bs28'
alias bs28='ssh apstrktr@bs28'
alias slicer.dc1.apstra.com='ssh apstrktr@slicer.dc1.apstra.com'

