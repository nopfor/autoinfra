#!/bin/sh

# SecLists
git clone https://github.com/danielmiessler/SecLists ~/wordlists/SecLists

# Assetnote Wordlists
mkdir ~/wordlists/assetnote/
cd ~/wordlists/assetnote/
wget -r --no-parent -R "index.html*" https://wordlists-cdn.assetnote.io/data/ -nH
cd -

