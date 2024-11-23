#!/system/bin/sh

# Dynamic Partitions
if dd if=/dev/block/by-name/system bs=256k count=1|strings|grep qti_dynamic_partitions > /dev/null; then
    echo >> /system/etc/recovery.fstab
    for p in odm product system system_ext vendor; do
        echo "${p} /${p} ext4 ro,barrier=1,discard wait,logical" >> /system/etc/recovery.fstab
    done
    echo >> /system/etc/twrp.flags
    for p in vendor; do
        echo "/super_${p} emmc /dev/block/by-name/${p} flags=display=\"Super_${p}\";backup=1" >> /system/etc/twrp.flags
    done
else
    # Fix MTG Installation
    ln -s /dev/block/bootdevice/by-name /dev/block/mapper

    echo >> /system/etc/twrp.flags
    cat /fstab/twrp.flags.nondynpart >> /system/etc/twrp.flags
    echo "/super emmc /dev/block/by-name/system flags=display=\"Super\";backup=1" >> /system/etc/twrp.flags
fi
