#!/usr/bin/env bash
get_info() {
    sensors | sed -E '/it87/,+18d'
    command -v cpupower &>/dev/null && cpupower frequency-info | sed "12s/  //;12q;d"
    # using this to omit useless sensors (may have messed up hardware)
    gpu_dpm_sclk="/sys/class/drm/card1/device/pp_dpm_sclk"
    if [ -e $gpu_dpm_sclk ]; then
        echo -e "\nGPU clock"
        cat $gpu_dpm_sclk
    fi
}
export -f get_info
watch -n1 get_info
