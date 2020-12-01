#!/bin/bash

mkdir -p ./tmp
cd ./tmp
# wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz

# tar -xf http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz

if [ ! -f "$1" ]; then
    echo "$1 does not exist."
fi

echo -e "\e[01;31mWARNING, this will wipe all data off of $1\e[0m"

read -p $'\e[01;31mWould you like to continue? [y/N]:: \e[0m' -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

read -p $'\e[01;31mAre you sure? [y/N]:: \e[0m' -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

echo "done"