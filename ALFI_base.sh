#!/bin/bash

loadkeys ru
setfont cyr-sun16

wifi-menu -o

echo 'Синхронизация системных часов'
timedatectl set-ntp true

echo 'Cоздание разделов'
(
 echo g;

 echo n;
 echo;
 echo;
 echo +128M;
 echo t;
 echo 1;

 echo n;
 echo;
 echo;
 echo +4G; 
 echo;
 echo t;
 echo;
 echo 19;

 echo n;
 echo;
 echo;
 echo;
 echo +320G;
 
 echo n;
 echo;
 echo;
 echo;
 echo t;
 echo;
 echo 16;

 echo w;
) | fdisk /dev/sda

echo 'Разметка диска:'
fdisk -l

echo 'Форматирование дисков'

mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4  /dev/sda3
mkfs.ext4 /dev/sda4

echo 'Монтирование дисков'
mount /dev/sda3 /mnt
mkdir /mnt/boot/
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
swapon /dev/sda2

echo 'Выбор зеркал для загрузки.'
pacman -Sy
pacman -S pacman-contrib --noconfirm
curl -s "https://www.archlinux.org/mirrorlist/?country=all&protocol=https&ip_version=4&ip_version=6" --output mirrorlist
sed -i 's/^#Server/Server/' mirrorlist
rankmirrors -n 17 mirrorlist > /etc/pacman.d/mirrorlist
rm mirrorlist

echo 'Установка основных пакетов'
pacstrap /mnt base base-devel

echo 'Настройка системы'
genfstab -U /mnt >> /mnt/etc/fstab

echo 'Полетели в систему!'
arch-chroot /mnt /bin/bash #sh -c "$(curl -fsSL 'https://raw.githubusercontent.com/HaskuldrKrionskij/ALFI/master/ALFI_chroot.sh')"???
