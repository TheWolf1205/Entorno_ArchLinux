#!/bin/bash

content=$1
echo "%{B#00000000}%{+u}%{u#808080}%{o3}$content%{-u}%{B-}"
