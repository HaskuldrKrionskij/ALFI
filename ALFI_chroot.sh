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
setfont cyr-sun16
echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo 'Готово!' 

echo 'Обновляется локаль системы'
locale-gen
echo 'Готово!'

echo 'Указывается язык системы'
localectl set-locale 'LANG=ru_RU.UTF-8'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo 'Готово!'

echo 'Вписывается KEYMAP=ru и FONT=cyr-sun16'
echo 'KEYMAP=ru' > /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf
echo 'Готово!'

echo 'Обновляется конфиг загрузочного RAM диска'
nano /etc/mkinitcpio.conf
echo 'Готово!'

echo 'Создаётся загрузочный RAM диск'
mkinitcpio -p linux
echo 'Готово!'

echo 'Устанавливается UEFI загрузчик'
pacman -S grub efibootmgr --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot/efi
echo 'Готово!'

echo 'Обновляется grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg
nano /boot/grub/grub.cfg
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
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
echo 'Готово!'

echo 'Раскомментируется репозиторий multilib для работы 32-битных приложений в 64-битной системе'
nano etc/pacman.conf
echo 'Готово!'

echo 'Обновление системы'
pacman -Syyuu --noconfirm
echo 'Готово!'

echo 'Необходимо авторизоваться Пользователем'
echo 'su %user%'