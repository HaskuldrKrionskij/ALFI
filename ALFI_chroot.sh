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
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

echo 'Раскомментируется репозиторий multilib для работы 32-битных приложений в 64-битной системе'
nano etc/pacman.conf
echo 'Готово!'

echo 'Обновление системы'
pacman -Syyuu --noconfirm
echo 'Готово!'

echo 'Вход в окружение пользователя'
su $username
cd
echo 'Готово!'

echo 'Устанавливаются драйвера'
sudo pacman -S xorg-server xorg-drivers xorg-xinit xorg-xbacklight netctl dialog dhclient dhcpcd wpa_supplicant ppp --noconfirm #virtualbox-guest-utils
echo 'Готово!'

echo "Устанавливается i3"
sudo pacman -S i3 dmenu --noconfirm
echo 'Готово!'

echo 'Устанавливаются шрифты'
sudo pacman -S ttf-liberation ttf-dejavu ttf-font-awesome --noconfirm
echo 'Готово!'

echo 'Установка дополнительных программ и пакетов'
sudo pacman -S chromium fireFox inkscape transmission-gtk libreoffice-fresh-ru bash-completion wget tor i2pd redshift thunar thunar-volman thunar-archive-plugin thunar-media-tags-plugin tumbler ffmpegthumbnailer freetype2 poppler-glib libgsf gvfs gvfs-gphoto2 gvfs-mtp gvfs-nfs feh imagemagick jpegexiforient GParted btrfs-progs dosfstools exfat-utils gpart mtools ntfs-3g polkit gnupg git xarchiver arj binutils bzip2 cpio gzip lha lrzip lz4 lzip lzop p7zip tar unarj unrar unzip xz zip zstd --noconfirm
echo 'Готово!'

echo 'Установка AUR (YAY)'
sudo pacman -S go --noconfirm
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xzf yay.tar.gz
cd yay
makepkg #-si --skipinteg
cd ..
rm -rf yay
echo 'Готово!'

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
pacman -Syyuu --noconfirm
echo 'Готово!'

echo 'Установка завершена!'
echo 'Перезапуск системы!'
exit
exit
umount -R /mnt
reboot