#!/bin/bash -ex
[ -z "$MOUNT_POINT" ] && MOUNT_POINT=/mnt/boot
[ -z "$DEVICE" ] && DEVICE=/dev/mmcblk0p1
[ -z "$SRC" ] && SRC=.
[ -z "$TMP" ] && TMP=/tmp/boot

umount ${DEVICE} &> /dev/null || true
mount ${DEVICE} $MOUNT_POINT
rm -rf $TMP
mkdir -p $TMP

cp -a $MOUNT_POINT/* $TMP
rm $TMP/MLO
rm $TMP/u-boot.img
rm -rf $MOUNT_POINT/*
sync
cp $SRC/MLO $MOUNT_POINT
cp $SRC/u-boot.img $MOUNT_POINT
cp -a $TMP/* $MOUNT_POINT

umount $MOUNT_POINT

