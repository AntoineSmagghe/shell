#!/bin/zsh
amixer set -c 1 Mic toggle | grep '\[off\]' && notify-send "$(echo -e '\u274C') Micro coupé" || notify-send "$(echo -e '\u2705') Micro actif"
