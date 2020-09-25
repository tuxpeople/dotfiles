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
cd ~/git/ansible-sky/roles
find . -d -empty -print
git clone https://github.com/dj-wasabi/ansible-telegraf.git ansible-telegraf
git clone https://github.com/linux-system-roles/firewall.git linux-system-roles.firewall
git clone https://github.com/ericsysmin/ansible-role-chrony.git ansible-role-chrony
git clone https://github.com/jnv/ansible-role-unattended-upgrades.git ansible-role-unattended-upgrades
git clone https://github.com/paulfantom/ansible-restic.git ansible.restic
git clone https://github.com/agaffney/ansible-synology-dsm.git ansible-synology-dsm
git clone https://github.com/geerlingguy/ansible-role-docker.git ansible-role-docker
git clone https://github.com/rlex/ansible-role-lm-sensors.git ansible-role-lm-sensors
git clone https://github.com/geerlingguy/ansible-role-nfs.git ansible-role-nfs
git clone https://github.com/linux-system-roles/cockpit linux-system-roles.cockpit

