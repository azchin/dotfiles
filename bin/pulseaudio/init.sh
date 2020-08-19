#!/bin/sh

export SINK=$(pacmd list-sinks|awk '/\* index:/{ print $3 }')
export SOURCE=$(pacmd list-sources|awk '/\* index:/{ print $3 }')
export MUTED=$(pacmd list-sinks|grep -A 15 '* index'|awk '/muted:/{ print $2 }')
export SOURCE_MUTED=$(pacmd list-sources|grep -A 15 '* index'|awk '/muted:/{ print $2 }')
export CURVOL=$(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g')

export UPPER_THRESHOLD=100


