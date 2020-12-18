#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir -p ./tmp
cd ./tmp

rm root -rf
rm boot -rf

FILE="ArchLinuxARM-rpi-2-latest.tar.gz"
URL="http://os.archlinuxarm.org/os/$FILE"
if [ ! -e "$FILE" ]; then
    wget $URL
fi

if [ ! -e "$1" ]; then
    echo "$1 does not exist."
    exit
fi

if [[ $1 != /dev/disk/* ]]; then
    echo "$1 is not under \`/dev/disk/*\`."
    exit
fi

DISK=$(readlink -f $1)

echo "Real path: $DISK"

echo -e "\e[01;31mWARNING, this will wipe all data off of $DISK\e[0m"

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

# ya this is no way a good way to do this. But Im rn too lazy to
# update it
# https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script
# https://serverfault.com/questions/258152/fdisk-partition-in-single-line
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo fdisk $DISK
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +200M # 100 MB boot parttion
  t # change partition type
  c # set the first partition to type W95 FAT32 (LBA).
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

yes | sudo mkfs.vfat "${DISK}1"
mkdir -p boot
mount "${DISK}1" boot

mkfs.ext4 -F "${DISK}2"
mkdir -p root
mount "${DISK}2" root

bsdtar -xpf $FILE -C root
sync

mv root/boot/* boot

umount boot root