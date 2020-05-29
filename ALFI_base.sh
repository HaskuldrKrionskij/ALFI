#!/bin/bash

echo 'Vybor lokali i shrifta'
loadkeys ru
setfont cyr-sun16
export LANG='ru_RU.UTF-8'
locale-gen
echo 'Готово!'

echo 'Запуск Wi-Fi'
wifi-menu -o
echo 'Готово!'

echo 'Включение системных часов'
timedatectl set-ntp true
echo 'Готово!'

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
echo 'Готово!'

echo 'Разметка диска:'
fdisk -l
echo 'Готово!'

echo 'Форматирование дисков'
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4  /dev/sda3
mkfs.ext4 /dev/sda4
echo 'Готово!'

echo 'Монтирование дисков'
mount /dev/sda3 /mnt
mkdir /mnt/boot/
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
swapon /dev/sda2
echo 'Готово!'

echo 'ВЫБОР БЫСТРЕЙШИХ ЗЕРКАЛ ДЛЯ ЗАГРУЗКИ'
echo 'Обновление базы'
pacman -Sy
echo 'Установка сортировщика зеркал'
pacman -S pacman-contrib --noconfirm
echo 'Скачиваем список подходящих зеркал'
curl -s "https://www.archlinux.org/mirrorlist/?country=all&protocol=https&ip_version=4&ip_version=6" --output mirrorlist
echo 'Чистка списка зеркал от #'
sed -i 's/#Server/Server/' mirrorlist
echo 'Соритровка списка зеркал по скорости..'
rankmirrors -n 17 mirrorlist > /etc/pacman.d/mirrorlist
echo 'Готово!'
rm mirrorlist

echo 'Установка основных пакетов'
pacstrap /mnt base base-devel linux linux-firmware nano wget
echo 'Готово!'

echo 'Настройка системы'
genfstab -U /mnt >> /mnt/etc/fstab
echo 'Готово!'

echo 'Пора!'