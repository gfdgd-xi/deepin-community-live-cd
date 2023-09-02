#!/bin/bash
rm -rf /tmp/gfdgd-xi-sources
mkdir -p /tmp/gfdgd-xi-sources
wget -P /tmp/gfdgd-xi-sources http://apt.gfdgdxi.top/gpg.asc
wget -P /tmp/gfdgd-xi-sources http://apt.gfdgdxi.top/sources/github.list
gpg --dearmor /tmp/gfdgd-xi-sources/gpg.asc
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FD6EEA1F20CD4B27
sudo cp -v /tmp/gfdgd-xi-sources/gpg.asc.gpg /etc/apt/trusted.gpg.d/gfdgdxi-list.gpg
sudo cp -v /tmp/gfdgd-xi-sources/github.list /etc/apt/sources.list.d/gfdgdxi-list.list
sudo apt update
