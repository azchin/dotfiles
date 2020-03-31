#!/bin/sh
sensors | sed -E '/it87/,+18d'
cpupower frequency-info | sed "13s/  //;13q;d"
# using this to omit useless sensors (may have messed up hardware)
