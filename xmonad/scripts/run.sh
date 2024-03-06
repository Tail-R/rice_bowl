#! /usr/bin/env bash

# dependencies: dmenu

# font
fname="azukifontB:size=12:weight=Bold"

# colors
nf="#776677"
nb="#fff5f5"
sf=$nb
sb=$nf

dmenu_run \
    -fn $fname \
    -nf $nf \
    -nb $nb \
    -sf $sf \
    -sb $sb
