#!/bin/sh
country=$1
reflector --latest 16 --sort rate -c ${country:=CA} --threads 8
