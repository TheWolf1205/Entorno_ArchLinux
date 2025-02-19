# Entorno de escritorio Bspwm ArchLinux (TheWolf1205 V1)

Aclaro que soy un gran novato en esto, así que cualquier recomendación o ayuda estaré mil veces agradecido.
La configuración de nvim en un principio es tomada de https://github.com/benbrastmckie/.config.git aunque medianamente modificada.

*Nota: Pasar fondo de neofetch*

## Preinstalación.

En este caso se asume que usted tiene los paquetes básicos de una instalación de ArchLinux, al igual dejaré una lista con lo que en mi opinión es lo mínimo (Claro, en un sistema EFI con dual boot, en un sistema distinto hay algunos que sobran).


```zsh
sudo pacman -Syu linux linux-firmware base base-devel grub os-prober efibootmgr networkmanager wpa_supplicant netctl dialog ntfs-3g nano vim git

```

## Instalación 
Asegurate de que el usuario tenga acceso a su carpeta home en su totalidad
```zsh
sudo chown -R $USER:$USER ~/
chmod -R 755 ~/
```

Crearemos una carpeta en la cual dejaremos el repositorio.
```zsh
cd
mkdir Git
cd Git
git clone https://github.com/TheWolf1205/Entorno_ArchLinux.git
```
Estos serán los paquetes necesarios para que el entorno funcione correctamente, recuerde que si usted no usa *paru*, también puede usar *yay* sin ningún problema, solo reemplace.
```zsh
paru -Syu arandr neofetch neovim zathura zathura-pdf-poppler wget sddm sxhkd bspwm ttf-hack-nerd ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-iosevka-nerd kitty lsd bat mdcat feh picom lxsession dunst gpaste polybar rofi papirus-icon-theme alsa-utils alsa-plugins alsa-firmware sof-firmware pamixer spotify firejail brave-bin flameshot pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth brightnessctl zsh zsh-syntax-highlighting zsh-autosuggestions xorg-xsetroot i3lock-color mpc python-notify2 python-psutil yad mplayer redshift playerctl surf texlive texlive-lang biber git lazygit fzf ripgrep pandoc-cli haskell-pandoc pandoc-crossref texlive-latex texlive-latexextra texlive-latexrecommended nodejs npm stylua lua-language-server wget xsel stylua unzip qt5 arc-solid-gtk-theme arc-icon-theme kvantum dolphin
```
Puede usar requisitos.sh para facilidad.
Ahora activaremos el servicio sddm para iniciar sesión.
```zsh
sudo systemctl enable sddm.service
```
Accedemos al repositorio y empezamos a pasar los archivos necesarios a su sitio.
```zsh
sudo mkdir /usr/share/zsh-sudo
sudo cp usr/share/zsh-sudo/sudo.plugin.zsh /usr/share/zsh-sudo/
cd Carpeta_Personal
sudo cp -r .config ~/
sudo su
mkdir /root/.config
cp -r .config/nvim /root/.config/
exit
```
Instalaremos la zsh-theme-powerlevel10k.
```zsh
paru -Sy zsh-theme-powerlevel10k-git --noconfirm
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
sudo usermod --shell zsh root
zsh
```
Configuras la p10k del usuario como desees.
```zsh
sudo cp -r .zshrc .p10k.zsh ~/
sudo su
```
Configuras la p10k de root como desees.
```zsh
exit
```
Para volver a tu usuario.
```zsh
cd ..
cd Carpeta_Personal_Root
cp -r .p10k.zsh /boot/root/
cd
sudo ln -sf ~/.zshrc /root/.zshrc
```
Instalamos fzf tanto en nuestro usuario como en root
```zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
Damos permiso al bloqueo
```zsh
sudo EDITOR=nano visudo
```
Y agregamos al final del archivo: 
TheWolf ALL=(ALL) NOPASSWD: /bin/tee /sys/power/state

Instalamos el (o los) temas de sddm:
```zsh
sudo cp -r themes-sddm/* /usr/share/sddm/themes
sudo nano /usr/lib/sddm/sddm.conf.d/default.conf
```
y dentro de este archivo en Theme Current colocamos el nombre del tema que nosotros hayamos escogido, en mi caso, relaxtronaut-main.
Ahora instalemos el tema del grub:
```zsh
sudo cp -r themes-grub/* /boot/grub/themes/
sudo nano /etc/default/grub
```
y en ese archivo agregamos:
```zsh
GRUB_THEME=/boot/grub/themes/fallout-grub-theme-master/theme.txt
```
por ultimo guardamos y:
```zsh
sudo os-prober
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Reinicie el ordenador y con esto debería de ser suficiente para que el entorno funcione teóricamente, no obstante, pueden ocurrir errores con la polybar debido a los nombres de las tarjetas de red, no obstante lo podrá corregir en el archivo ~/.config/polybar/current.ini en particular en los módulos wifi y ethernet.\\

## Recomendación
Este repositorio tiene un archivo postinstall que puede ser útil:
https://github.com/sudorook/archlinux

## Nota
Cualquier duda no duden en preguntar o si quieren aportar algo que le sea útil al entorno, maravilloso.
Ya apartir de este punto te instalas las aplicaciones y paquetes de tu gusto.
