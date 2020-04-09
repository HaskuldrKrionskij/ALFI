#!/bin/bash
read -p "Введите имя компьютера: " hostname
read -p "Введите имя с маленькой(!) буквы пользователя: " username

echo 'Прописывается имя компьютера'
echo hostnamectl set-hostname $hostname
echo timedatectl set-timezone Europe/Moscow
echo localectl set-keymap ru

echo 'Добавляется локаль системы'
echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen 

echo 'Обновляется локаль системы'
locale-gen

echo 'Указывается язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf

echo 'Вписывается KEYMAP=ru и FONT=cyr-sun16'
echo 'KEYMAP=ru' > /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Создаётся загрузочный RAM диск'
mkinitcpio -p linux

echo '3.5 Устанавливается UEFI загрузчик'
pacman -S grub efibootmgr --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot/efi

echo 'Обновляется grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg #Возможно ли с помощью bash найти и заменить строку???

echo 'Добавляется пользователь'
useradd -m -g users -G wheel -s /bin/bash $username

echo 'Укажите root пароль'
passwd

echo 'Укажите пароль пользователя'
passwd $username

echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers #Возможно ли с помощью bash найти и заменить строку???

echo 'Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf #Возможно ли с помощью bash найти и заменить строку???
pacman -Syyuu --noconfirm

echo 'Устанавливаются драйвера'
pacman -S xorg-server xorg-drivers xorg-xinit bash-completion dialog dhclient dhcpcd wpa_supplicant ppp --noconfirm #virtualbox-guest-utils

echo "Устанавливается i3"
# pacman -S --noconfirm ПОДГОТОВИТЬ НАБОР ПАКЕТОВ

echo 'Устанавливаются шрифты'
#pacman -S ttf-liberation ttf-dejavu --noconfirm ПОДГОТОВИТЬ НАБОР ШРИФТОВ А ТАКЖЕ РАССМОТРЕТЬ FONT-AWESOME


echo 'Устанавливается автозапуск интернета'
#systemctl enable netctl???
systemctl enable netctl.service

pacman -Syyuu --noconfirm

echo 'Установка завершена!'
echo 'Перезапуск системы!'
exit
umount -R /mnt
reboot