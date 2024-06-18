#!/bin/bash
#vol=$(amixer -D pulse get Master | grep -oE '[0-9]{1,3}?%' | head -1)
#echo "$vol"

#!/bin/bash

# Get volume and mute status
amixer_output=$(amixer -D pulse get Master)
volume=$(echo "$amixer_output" | grep -oE '[0-9]{1,3}?%' | head -1)
mute=$(echo "$amixer_output" | grep -oE '\[(on|off)\]' | tail -1 | sed 's/^.//')


# Format output
if [ "$mute" = "off]" ]; then
    echo " 00"
else
    echo "  $volume" | sed 's/%//'
fi

