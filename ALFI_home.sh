#!/bin/bash

cd
echo 'Поехали!'

echo 'Устанавливаются драйвера'
sudo pacman -S xorg-server xorg-xinit mesa xorg-xbacklight netctl dialog dhclient dhcpcd wpa_supplicant ppp --noconfirm #virtualbox-guest-utils
echo 'Готово!'

echo "Устанавливается i3"
sudo pacman -S i3 dmenu --noconfirm
echo 'Готово!'

echo 'Устанавливаются шрифты'
sudo pacman -S ttf-liberation ttf-dejavu ttf-font-awesome --noconfirm
echo 'Готово!'

echo 'Установка дополнительных программ и пакетов'
sudo pacman -S bash-completion pulseaudio pulseaudio-alsa chromium firefox inkscape transmission-gtk wget tor i2pd redshift thunar thunar-volman thunar-archive-plugin thunar-media-tags-plugin tumbler ffmpegthumbnailer freetype2 poppler-glib libgsf gvfs gvfs-gphoto2 gvfs-mtp gvfs-nfs feh imagemagick jpegexiforient gparted btrfs-progs dosfstools exfat-utils gpart mtools ntfs-3g polkit gnupg git xarchiver arj binutils bzip2 cpio gzip lha lrzip lz4 lzip lzop p7zip tar unarj unrar unzip xz zip zstd keepassxc mousepad hexchat --noconfirm
echo 'Готово!'

echo 'Установка AUR (YAY)'
sudo pacman -S go --noconfirm
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xzf yay.tar.gz
cd yay
makepkg -si
cd ..
rm -rf yay
echo 'Готово!'

echo 'Дополнительаня установка из AUR'
yay -S pulseaudio-ctl sublime-text-dev sublime-merge hexchat-otr --noconfirm
echo 'Готово'

echo 'Устанавливается автозапуск интернета'
sudo systemctl enable netctl.service
echo 'Готово!'

echo 'Создаются базовые директории'
mkdir Downloads
mkdir Documents
mkdir Images
mkdir Musics
mkdir Videos
echo 'Готово!'

echo 'Обновление системы'
yay -Syyuu
echo 'Готово!'

echo 'Копирование и редактирование .xinitrc'
cp /etc/X11/xinit/xinitrc ~/.xinitrc
nano ~/.xinitrc
echo'Готово'

echo 'Автозапуск X при авторизации'
echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> ~/.bash_profile
nano ~/.bash_profile
echo 'Готово!'

echo 'Система готова к использованию'
echo 'Необходимо перезапустить систему!'
echo '$ reboot'