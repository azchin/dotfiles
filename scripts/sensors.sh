#!/bin/sh
sensors | tail -n+20
# using this to omit useless sensors (may have messed up hardware)
