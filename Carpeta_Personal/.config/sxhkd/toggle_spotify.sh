#!/bin/bash

# Obtener el estado actual de reproducción
status=$(playerctl --player=spotify status)

if [ "$status" == "Playing" ]; then
    playerctl --player=spotify pause
else
    playerctl --player=spotify play
fi
