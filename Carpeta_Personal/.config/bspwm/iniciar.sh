#!/usr/bin/env sh

#Fondo de pantalla
feh --bg-fill /home/TheWolf/Imágenes/Fondos/1.jpg &

#Picom
picom --experimental-backends &

#Bordes
bspc config border_width 0 &

#Distribucion de teclado
setxkbmap latam &
