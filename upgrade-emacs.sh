#!/bin/bash
set -ex

sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install -y \
	emacs26 \
    cscope \
    clang

ln -f -s /etc/alternatives/emacs-26.2 /etc/alternatives/emacs
[[ ! "$ver" = "26"* ]] && echo "Failed to upgrade emacs"
var=$(emacs --version | head -1 | awk '{print $NF}' | awk -F . '{print $1}')
(( $var >= 26 )) && echo "emacs version is upgraded"
