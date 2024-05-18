#! /bin/bash

fondos=()

for archivo in ~/.config/polybar/scripts/fondos/*;
do
  fondos+=("$archivo")
done

fondos=($(shuf -e "${fondos[@]}"))

while [[ 1 < 2 ]];do 
  i=0
  while [[ $i < ${#fondos[@]} ]]; do
    feh --bg-fill ${fondos[$i]}
    sleep 1200
    ((i++))
  done
done
