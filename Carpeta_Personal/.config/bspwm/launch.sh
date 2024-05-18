#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Agente polkit
lxpolkit &

# Iniciar dbs
dbus-run-session bspwm &

# Remove x cursor
xsetroot -cursor_name left_ptr &

## Launch

#Notificaciones para la bateria
systemctl --user restart dunst &

python3 /home/TheWolf/Programas/bateria.py &

# Gpaste
gpaste-client start &

#Icono Arch - Rofi
polybar log -c ~/.config/polybar/current.ini &

#Fecha
polybar secondary -c ~/.config/polybar/current.ini &

#Volumen
polybar volumen -c ~/.config/polybar/current.ini &

#Bateria
polybar top -c ~/.config/polybar/current.ini &

#SysMenu
polybar primary -c ~/.config/polybar/current.ini &

#Wifi
polybar terceary -c ~/.config/polybar/current.ini &

#Memoria RAM
polybar quaternary -c ~/.config/polybar/current.ini &

#CPU
polybar cinconary -c ~/.config/polybar/current.ini &

#Ethernet
polybar networkry -c ~/.config/polybar/current.ini &

#Escritorios
polybar primary -c ~/.config/polybar/workspace.ini &

#Escritorios
polybar secondary -c ~/.config/polybar/workspace.ini &

#Fondo de pantalla
bash ~/.config/polybar/scripts/fondos.sh &

#Distribucion de teclado
setxkbmap latam &

#Picom
pkill picom
picom -f --daemon --config "${HOME}/.config/picom/picom.conf" &

