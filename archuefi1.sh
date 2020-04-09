#!/bin/bash

loadkeys ru
setfont cyr-sun16

#ДОБАВИТЬ ЗАПУК СЕТИ

echo 'Синхронизация системных часов'
timedatectl set-ntp true

echo 'Cоздание разделов' #КОРРЕКТИРОВАТЬ ПОД СЕБЯ
(
 echo g;

 echo n;
 echo ;
 echo;
 echo +300M;
 echo y;
 echo t;
 echo 1;

 echo n;
 echo;
 echo;
 echo +30G;
 echo y;
 
  
 echo n;
 echo;
 echo;
 echo;
 echo y;
  
 echo w;
) | fdisk /dev/sda

echo 'Разметка диска:'
fdisk -l

echo 'Форматирование дисков'

mkfs.fat -F32 /dev/sda1
#mkswapon /dev/sda2 КОРРЕКТИРОВАТЬ
mkfs.ext4  /dev/sda3

echo 'Монтирование дисков'
mount /dev/sda3 /mnt
mkdir /mnt/boot/
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
swapon /dev/sda2

echo 'Выбор зеркал для загрузки.' #УСТАНОВИТЬ И ИСПОЛЬЗОВАТЬ СКРИПТ ПО АВТОМАТИЧЕСКОЙ НАСТРОЙКЕ ЗЕРКАЛ

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel bash-complection #ДОБАВИТЬ ПАКЕТЫ ДЛЯ netctl и БЫТЬ МОЖЕТ ДРУГИЕ

echo '3.3 Настройка системы'
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt #sh -c "$(curl -fsSL git.io/archuefi2.sh)"???
