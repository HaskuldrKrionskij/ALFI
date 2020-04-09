#!/bin/bash
read -p "Введите имя компьютера с маленькой(!) буквы: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописывается имя компьютера'
echo $hostname > /etc/hostname
#ln -svf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime???

echo '3.4 Добавляем русскую локаль системы'
echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen 

echo 'Обновляется текущая локаль системы'
locale-gen

echo 'Указывается язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf

echo 'Вписывается KEYMAP=ru и FONT=cyr-sun16'
echo 'KEYMAP=ru' > /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Создаётся загрузочный RAM диск'
mkinitcpio -p linux

echo '3.5 Устанавливается UEFI загрузчик'
#pacman -S grub efibootmgr --noconfirm???
grub-install /dev/sda

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
pacman -Syyuu

echo "Arch Linux устанавливается на виртуальную машину?" #ПРОВЕРИТЬ со своим набором
read -p "1 - Да, 0 - Нет: " vm_setting
if [[ $vm_setting == 0 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit"
elif [[ $vm_setting == 1 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils"
fi

echo 'Устанавливаются драйвера'
pacman -S $gui_install

echo "Устанавливается i3"
# pacman -S --noconfirm ПОДГОТОВИТЬ НАБОР ПАКЕТОВ

echo 'Устанавливаются шрифты'
#pacman -S ttf-liberation ttf-dejavu --noconfirm ПОДГОТОВИТЬ НАБОР ШРИФТОВ А ТАКЖЕ РАССМОТРЕТЬ FONT-AWESOME


echo 'Устанавливается автозапуск интернета'
#systemctl enable netctl???

echo 'Установка завершена!'
echo 'Перезапуск системы!'
exit
umount -R /mnt
reboot