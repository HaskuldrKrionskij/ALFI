##############################################
# ArchLinux Fast Install v2.2
##############################################

# Описание
Этот скрипт не задумывался, как обычный установочный с большим выбором DE, разметкой диска и т.д. И он не предназначет для новичков. Он предназначен для тех, кто ставил ArchLinux руками и понимает, что и для чего нужна каждая команда. 

Его цель - это моментальное разворачиванеи системы со всеми конфигами. Смысл в том что, все изменения вы делаете предварительно в самом скрипте и получаете возможность быстрой установки ArchLinux с вашими личными настройками (при условии, что вы его изменили под себя, в противном случае с моими настройками).

Cкрипт основан на моем чек листе ручной установке ArchLinux https://vk.cc/7JTg6U
Этот скрипт работает с UEFI. Для работы с Legasy/BIOS используйте предыдущий скрипт https://github.com/ordanax/arch2018

Cостоит из 3 частей.  
1-й и 2-й - это базовая установка Arch Linux c XFCE  
3-й - мой конфиг системы. Подключение AUR, кастомизация XFCE, установка нужных программ, авто вход и т.д.  

# Установка 
1) Скачать и записать на флешку ISO образ Arch Linux https://www.archlinux.org/download/
2) Скачать и запустить скрипт командой:

   ```bash 
   wget git.io/archuefi1.sh && sh archuefi1.sh
   ```
   Запустится установка минимальной системы.
   2-я часть ставится автоматически и это базовая установка ArchLinux без программ. 
3) 3-я часть не обязательная. Она устанавливает программы, AUR (yay), мои конфиги XFCE.
   Предварительно установите wget командой:
   ```bash 
   sudo pacman -S wget
   ```
   Установка 3-й части производится из терминала командой:
   
   ```bash 
   wget git.io/archuefi3.sh && sh archuefi3.sh
   ```

# Настройка скрипта под себя
Вы можете форкнуть этот срипт. Изменить разметку дисков под свои нужды, сделать копию собственного конфга XFCE, залить его на Github и производить быстрое разворачивание вашей системы.
По завершению работы скрипта вы получаете вашу готовую и настроенную систему со всеми конфигами. Вам ее нужно лишь немного привести в порядок и все.
Как и что менять написано в комментариях в самом скрипте.

# ВНИМАНИЕ!
Автор не несет ответственности за любое нанесение вреда при использовании скрипта. Используйте его на свой страх и риск или изменяйте под свои личные нужды.

Скрипт затирает диск dev/sda в системе. Поэтому если у вас есть ценные данные на дисках сохраните их. Если вам нужна установка рядом с Windows, тогда вам нужно предварительно изменить скрипт и разметить диски. В противном случае данные и Windows будут затерты.

Если вам не подходит автоматическая разметка дисков, тогда вам, предварительно нужно сделать разметку дисков и настроить скрипт под свои нужды (программы, XFCE config и т.д.)
Смотрите пометки в самом скрипте.

Автор скрипта Алексей Бойко https://vk.com/ordanax

Помогали в разработке: 

Степан Скрябин https://vk.com/zurg3  
Михаил Сарвилин https://vk.com/michael170707  
Данил Антошкин https://vk.com/danil.antoshkin  
Юрий Порунцов https://vk.com/poruncov  
Alex Creio https://vk.com/creio  


# Контакты
Наша группа по Arch Linux https://vk.com/arch4u


# История изменений
### 08.03.2020 ArchLinux Fast Install v2.2 В archuefi3.sh добавлен выбор автовхода без DE
### 24.01.2020 ArchLinux Fast Install v2.1 На выбор добавлен i3wv с моими конфигами
### 01.10.2019 ArchLinux Fast Install v2.0 Переход на UEFI
