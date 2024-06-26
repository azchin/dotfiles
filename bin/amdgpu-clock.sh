#!/usr/bin/env bash
# https://wiki.archlinux.org/title/AMDGPU#Manual_(default)
# https://docs.kernel.org/6.1/gpu/amdgpu/thermal.html

# echo "r" > $gpu_device # to reset

# Defaults
# OD_SCLK:
# 0:        300MHz        750mV
# 1:        909MHz        831mV
# 2:       1134MHz       1012mV
# 3:       1266MHz       1162mV
# 4:       1365MHz       1150mV
# 5:       1432MHz       1150mV
# 6:       1490MHz       1150mV
# 7:       1545MHz       1150mV
# OD_MCLK:
# 0:        400MHz        750mV
# 1:       1000MHz        900mV
# 2:       2000MHz        950mV
# OD_RANGE:
# SCLK:     300MHz       2000MHz
# MCLK:     400MHz       2250MHz
# VDDC:     750mV        1212mV

gpu_device="/sys/class/drm/card1/device/pp_od_clk_voltage"
gpu_dpm_sclk="/sys/class/drm/card1/device/pp_dpm_sclk"
max_voltage=1150
declare -A clocks
clocks[3]=1266
clocks[4]=1364
clocks[5]=1420
clocks[6]=1464
clocks[7]=1496
for idx in $(echo "${!clocks[@]}" | sed 's/\s/\n/g' | sort); do
    echo "echo \"s ${idx} ${clocks[$idx]} ${max_voltage}\" > ${gpu_device}"
    if [ $(id -u) -eq 0 ]; then
        echo "s ${idx} ${clocks[$idx]} ${max_voltage}" > ${gpu_device}
    fi
done
echo "echo \"c\" > ${gpu_device}"
if [ $(id -u) -eq 0 ]; then
    echo "c" > ${gpu_device}
fi
cat $gpu_device
cat $gpu_dpm_sclk
