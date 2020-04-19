#!/bin/bash

read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя с маленькой(!) буквы: " username

echo 'Прописывается имя компьютера'
echo hostnamectl set-hostname $hostname
echo 'Готово!'

echo 'Выставляется часовой пояс'
echo timedatectl set-timezone Europe/Moscow
echo 'Готово!'

echo 'Выставляется тип раскладки (RU)'
echo localectl set-keymap ru
echo 'Готово!'

echo 'Добавляется локаль системы'
echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo 'Готово!' 

echo 'Обновляется локаль системы'
locale-gen
echo 'Готово!'

echo 'Указывается язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo 'Готово!'

echo 'Вписывается KEYMAP=ru и FONT=cyr-sun16'
echo 'KEYMAP=ru' > /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf
echo 'Готово!'

echo 'Создаётся загрузочный RAM диск'
mkinitcpio -p linux
echo 'Готово!'

echo 'Устанавливается UEFI загрузчик'
pacman -S grub efibootmgr --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot/efi
echo 'Готово!'

echo 'Обновляется grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg #Возможно ли с помощью bash найти и заменить строку???
echo 'Готово!'

echo 'Добавляется пользователь'
useradd -m -g users -G wheel -s /bin/bash $username
echo 'Готово!'

echo 'Укажите root пароль'
passwd
echo 'Готово!'

echo 'Укажите пароль пользователя'
passwd $username
echo 'Готово!'

echo 'Устанавливается SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers #Возможно ли с помощью bash найти и заменить строку???

echo 'Раскомментируется репозиторий multilib для работы 32-битных приложений в 64-битной системе'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf #Возможно ли с помощью bash найти и заменить строку???
echo 'Готово!'

echo 'Обновление системы'
pacman -Syyuu --noconfirm
echo 'Готово!'

echo 'Устанавливаются драйвера'
pacman -S xorg-server xorg-drivers xorg-xinit dialog dhclient dhcpcd wpa_supplicant ppp --noconfirm #virtualbox-guest-utils
echo 'Готово!'

echo "Устанавливается i3"
# pacman -S i3-wm i3-gaps i3status sbxkb dmenu pcmanfm feh lxappearance thunar gvfs udiskie xorg-xbacklight ristretto tumbler compton --noconfirm ПОДГОТОВИТЬ НАБОР ПАКЕТОВ
echo 'Готово!'

echo 'Устанавливаются шрифты'
pacman -S ttf-liberation ttf-dejavu ttf-font-awesome --noconfirm
echo 'Готово!'

echo 'Установка дополнительных программ и пакетов'
sudo pacman -S Chromium FireFox Inkscape Transmission-CLI Transmission-GTK UFw GUFw LibreOffice-fresh-ru Bash-completion WGet TOR I2Pd --noconfirm
#yay -S google-chrome --noconfirm
echo 'Готово!'

echo 'Установка AUR (YAY)'
sudo pacman -Syyuu
wget https://gist.githubusercontent.com/HaskuldrKrionskij/eb207dad642be5b012c5a36a16823074/raw/6a080c05e9f662ff58dbb9e2bd11ec15276e58de/iYAY.sh
sh iYAY.sh
rm iYAY.sh
echo 'Готово!'

echo 'Установка Tor Browser'
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org
yay -S tor-browser --noconfirm
echo 'Готово!'

echo 'Устанавливается автозапуск интернета'
systemctl enable netctl.service
echo 'Готово!'

echo 'Создаются базовые директории'
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Images
mkdir ~/Musics
mkdir ~/Videos
echo 'Готово!'

echo 'Обновление системы'
pacman -Syyuu --noconfirm
echo 'Готово!'

echo 'Установка завершена!'
echo 'Перезапуск системы!'
reboot
