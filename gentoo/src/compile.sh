#!/bin/sh
cd /usr/src/linux
make && \
make modules_install && \
make install  && \
genkernel --install --kernel-config=/usr/src/linux/.config initramfs && \
grub-mkconfig -o /boot/grub/grub.cfg
