#!/bin/bash

# Obtener el mes y año actual
current_month=$(date "+%m")
current_year=$(date "+%Y")

# Argumento opcional para especificar el desplazamiento del mes
offset_month="${1:-0}"

# Calcular el mes y año para mostrar
show_month=$(date -d "${current_year}-${current_month}-01 + ${offset_month} month" "+%m")
show_year=$(date -d "${current_year}-${current_month}-01 + ${offset_month} month" "+%Y")

# Eliminar ceros a la izquierda del mes
show_month=$(printf "%d" "$show_month")

# Posición
x_position=10
y_position=50

# Mostrar el calendario del mes especificado usando yad
yad --calendar --no-buttons --title=" Calendario " --undecorated --close-on-unfocus --fixed --width=180 --height=200 --text=" " --month="${show_month}" --year="${show_year}" --geometry="+${x_position}+${y_position}"

