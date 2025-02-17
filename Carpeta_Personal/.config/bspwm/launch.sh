#!/usr/bin/env sh

export BATTERY=$(ls /sys/class/power_supply/ | grep '^BAT')

# Detectar la interfaz WiFi y Ethernet automáticamente
WIFI=$(ip link show | awk -F ': ' '/wlan|wl/ {print $2; exit}')
ETHERNET=$(ip link show | awk -F ': ' '/eth|en/ {print $2; exit}')

# Si no encuentra nada, usa valores por defecto
[ -z "$WIFI" ] && WIFI="wlan0"
[ -z "$ETHERNET" ] && ETHERNET="eth0"

# Exportar variables para Polybar
export WIFI
export ETHERNET

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

python3 ~/.config/polybar/scripts/bateria.py &

# Gpaste
gpaste-client start &

#polybar barra -c ~/.config/polybar/current.ini &

#Icono Arch - Rofi
#polybar log -c ~/.config/polybar/current.ini &

#Fecha
#polybar secondary -c ~/.config/polybar/current.ini &

#Volumen
#polybar volumen -c ~/.config/polybar/current.ini &

#Bateria
#polybar top -c ~/.config/polybar/current.ini &

#SysMenu
#polybar primary -c ~/.config/polybar/current.ini &

#Wifi
#polybar terceary -c ~/.config/polybar/current.ini &

#Memoria RAM
#polybar quaternary -c ~/.config/polybar/current.ini &

#CPU
#polybar cinconary -c ~/.config/polybar/current.ini &

#Ethernet
#polybar networkry -c ~/.config/polybar/current.ini &

#Escritorios
#polybar primary -c ~/.config/polybar/workspace.ini &

#Escritorios
#polybar secondary -c ~/.config/polybar/workspace.ini &

# Barra polybar
polybar barra -c ~/.config/polybar/current.ini &

#Fondo de pantalla
bash ~/.config/polybar/scripts/fondos.sh &

#Distribucion de teclado
setxkbmap latam &

#Scroll del TouchPad Antinatural
xinput --set-prop 9 'libinput Natural Scrolling Enabled' 1 &

#Picom
pkill picom
picom -f --daemon --config "${HOME}/.config/picom/picom.conf" &

