# Entorno de escritorio Bspwm ArchLinux (TheWolf1205 V1)

Aclaro que soy un gran novato en esto, así que cualquier recomendación o ayuda estaré mil veces agradecido.

## Preinstalación.

En este caso se asume que usted tiene los paquetes básicos de una instalación de ArchLinux, al igual dejaré una lista con lo que em mi opinión es lo mínimo (Claro, en un sistema EFI con dual boot, en un sistema distinto hay algunos que sobran).


```zsh
sudo pacman -Syu linux linux-firmware base base-devel grub os-prober efibootmgr networkmanager wpa_supplicant netctl dialog ntfs-3g nano vim 

```

## Instalación 
Estos serán los paquetes necesarios para que el entorno funcione correctamente, recuerde que si usted no usa *paru*, también puede usar *yay* sin ningún problema, solo reemplace.
```zsh
paru -Syu git wget sddm sxhkd bspwm ttf-hack-nerd ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-iosevka-nerd kitty lsd bat mdcat feh picom lxsession dunst gpaste polybar rofi papirus-icon-theme alsa-utils alsa-plugins alsa-firmware sof-firmware pamixer spotify firejail brave-bin flameshot pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth brightnessctl zsh zsh-syntax-highlighting zsh-autosuggestions xorg-xsetroot slock mpc
```
Ahora activaremos el servicio sddm para iniciar sesión.
```zsh
sudo systemctl enable sddm.service
```
Crearemos una carpeta en la cual dejaremos el repositorio.
```zsh
cd
mkdir Git
cd Git
git clone https://github.com/TheWolf1205/Entorno_ArchLinux.git
```
Accedemos al repositorio y empezamos a pasar los archivos necesarios a su sitio.
```zsh
cd Entorno_ArchLinux
sudo mkdir /usr/share/zsh-sudo
cp usr/share/zsh-sudo/sudo.plugin.zsh /usr/share/zsh-sudo/
cd Carpeta_Personal
sudo cp -r .config ~/
```
Instalaremos la zsh-theme-powerlevel10k.
```zsh
paru -Sy --noconfirm zsh-theme-powerlevel10k-git
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

Reinicie el ordenador y con esto debería de ser suficiente para que el entorno funcione teoricamente, no obstante, pueden ocurrir errores con la polybar debido a los nombres de las tarjetas de red, no obstante lo podrá corregir en el archivo ~/.config/polybar/current.ini en particular en los modulos wifi y ethernet.

## Nota
Cualquier duda no duden en preguntar o si quieren aportar algo que le sea útil al entorno, maravilloso.
Ya apartir de este punto te instalas las aplicaciones y paquetes de tu gusto.
