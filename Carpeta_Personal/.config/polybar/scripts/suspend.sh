#!/bin/bash
echo mem | sudo tee /sys/power/state
bash ~/.config/polybar/scripts/lock
