#!/bin/sh

set -eu

get_block_uuid() {
    blkid | sed -En 's;^'"${1}"':.* UUID="([^"]+).*";\1;p'
}

get_path_uuid() {
    btrfs filesystem show / | sed -En 's;.*uuid: ([a-zA-Z0-9\-]+).*;\1;p'
}

get_subvol_name() {
    btrfs subvolume show / | sed -En 's;.*Name:\s*(\w+).*;\1;p'
}

get_subvol_id() {
    btrfs subvolume show / | sed -En 's;.*Subvolume ID:\s*(\w+).*;\1;p'
}

LABEL=${1:-"Arch Linux"}
BLOCK_UUID=$(get_path_uuid)
SWAPFILE_OFFSET=$(btrfs inspect-internal map-swapfile --resume-offset /swap/swapfile)
ROOT_SUBVOLID=$(get_subvol_id)

RESUME="resume=UUID=${BLOCK_UUID} resume_offset=${SWAPFILE_OFFSET}"
RYZEN="rcu_nocbs=0-11 processor.max_cstate=1"
EXTRA="${RYZEN}"
KERNEL_OPTIONS="root=UUID=${BLOCK_UUID} ${RESUME} rw rootflags=subvolid=${ROOT_SUBVOLID} initrd=\initramfs-linux.img ${EXTRA}"


echo "efibootmgr --create
	--disk /dev/sdc --part 1
	--label ${LABEL}
	--loader /vmlinuz-linux
	--unicode ${KERNEL_OPTIONS}"

if [ $(id -u) -eq 0 ]; then
    echo "Writing EFISTUB!"
    efibootmgr --create \
        --disk /dev/sdc --part 1 \
        --label "${LABEL}" \
        --loader /vmlinuz-linux \
        --unicode "${KERNEL_OPTIONS}"
fi
