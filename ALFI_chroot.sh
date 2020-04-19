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

echo '3.5 Устанавливается UEFI загрузчик'
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


echo 'Устанавливается автозапуск интернета'
#systemctl enable netctl???
systemctl enable netctl.service
echo 'Готово!'

echo 'Обновление системы'
pacman -Syyuu --noconfirm
echo 'Готово!'

echo 'Начальная завершена!'
echo 'Перезапуск системы!'
exit
umount -R /mnt
reboot