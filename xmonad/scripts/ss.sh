#!/usr/bin/env bash

# dependencies: maim

SS_DIR="$HOME/Pictures/screenshots"

mkdir -p $HOME/Pictures
mkdir -p $SS_DIR

ss_name=$(date "+%Y%m%d_%H%M%S.png")

case "$1" in
    "-s" )
        maim -u -m 10 -s $SS_DIR/$ss_name
        ;;
    "-f" )
        maim -u -m 10 $SS_DIR/$ss_name
        ;;
    * )
        maim -u -m 10 $SS_DIR/$ss_name
        ;;
esac
