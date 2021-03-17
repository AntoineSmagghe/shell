#!/bin/zsh

# Toggle PC intagrated microphone
amixer set Capture toggle | grep '\[off\]' && notify-send "$(echo -e '\u274C') Micro coupé" || notify-send "$(echo -e '\u2705') Micro actif"

# Toggle USB microphone
amixer set -c 1 Mic toggle
