#!/bin/bash
set -ex

sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install -y \
	emacs26 \
    cscope \
    clang

[ -f /etc/alternatives/emacs-26.2 ] && echo "/etc/alternatives/emacs-26.2 not installed properly"
ln -fs /etc/alternatives/emacs-26.2 /etc/alteratives/emacs
[ -f /etc/alteratives/emacs ] && echo "Failed to map logical links properly"

