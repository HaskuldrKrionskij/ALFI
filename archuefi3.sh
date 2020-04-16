#!/bin/bash

echo 'Создаются нужные директории'
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Images
mkdir ~/Musics
mkdir ~/Videos

echo 'Установка AUR (YAY)'
sudo pacman -Syyuu
sudo pacman -S wget --noconfirm #НА ВСЯКИЙ СЛУЧАЙ
wget https://gist.githubusercontent.com/HaskuldrKrionskij/eb207dad642be5b012c5a36a16823074/raw/6a080c05e9f662ff58dbb9e2bd11ec15276e58de/iYAY.sh
sh iYAY.sh

echo 'Установка дополнительных программ и пакетов'
#sudo pacman -S firefox firefox-i18n-ru ufw f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils file-roller p7zip unrar gvfs aspell-ru pulseaudio pavucontrol --noconfirm КОРРЕКТИРОВАТЬ ПОД СЕБЯ
#yay -S --noconfirm ПРИ НЕОБХОДИМОСТИ

echo "Установка i3 конфигураций?" #КОРРЕКТИРОВАТЬ ПОД СЕБЯ
#pacman -S i3-wm i3-gaps i3status sbxkb dmenu pcmanfm ttf-font-awesome feh lxappearance thunar gvfs udiskie xorg-xbacklight ristretto tumbler compton --noconfirm
#yay -S polybar
#wget https://github.com/ordanax/dots/raw/master/i3wm_v_2/i3wm_config.tar.gz
#sudo rm -rf ~/.config/i3/*
#sudo rm -rf ~/.config/polybar/*
#sudo tar -xzf i3wm_config.tar.gz -C ~/

#echo 'Убираем меню граб для выбора системы?'
#read -p "1 - Да, 0 - Нет: " grub_set
#if [[ $grub_set == 1 ]]; then
#  wget git.io/grub.tar.gz
#  sudo tar -xzf grub.tar.gz -C /
#  sudo grub-mkconfig -o /boot/grub/grub.cfg
#elif [[ $grub_set == 0 ]]; then
#  echo 'Пропускаем.'
#fi

#echo 'Включаем сетевой экран'
#sudo ufw enable
#echo 'Добавляем в автозагрузку:'
#sudo systemctl enable ufw

#rm -R ~/downloads/
#rm -rf ~/archuefi3.sh

echo 'Установка завершена!'
echo 'Перезапуск системы!'
reboot
