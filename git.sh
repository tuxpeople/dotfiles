#!/bin/bash
# Checkout all my github repos
mkdir ~/git
cd ~/git
for i in $(wget -q -O- "https://github.com/tuxpeople?tab=repositories" | grep tuxpeople | grep codeRepository | cut -d'"' -f2 | cut -d'/' -f3)
do
  git clone git@github.com:tuxpeople/$i.git
done
git clone git@github.com:tuxpeople/docker-compose.git
git clone --recursive git@github.com:tuxpeople/ansible-sky.git
cd ~/git/ansible-sky/3rd-party
find . -d -empty -print
git clone https://github.com/puzzle/ansible-rancher.git
