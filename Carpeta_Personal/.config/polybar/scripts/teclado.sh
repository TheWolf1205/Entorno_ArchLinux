# !/bin/bash

# Revisa la distribución actual
# current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

# Alterna entre distribuciones
# if [ "$current_layout" = "us" ]; then
    # setxkbmap latam
# else
    # setxkbmap us
# fi

#!/bin/bash

# Revisa la distribución actual
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

# Alterna entre distribuciones
case "$current_layout" in
    us)
        setxkbmap latam
        ;;
    latam)
        setxkbmap es
        ;;
    es)
        setxkbmap us
        ;;
    *)
        setxkbmap us
        ;;
esac


