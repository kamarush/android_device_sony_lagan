#!/system/bin/sh
setprop gsm.radio.kickstart off

if [ $(getprop ro.boot.baseband) == "mdm" ]; then

    if [ ! -d /data/qcks ]; then
       rm -rf /data/qcks
       mkdir /data/qcks
       chmod 0770 /data/qcks
       chown system:system /data/qcks
    fi

    for f in $(ls /data/qcks/); do
        (ls -l /data/qcks/$f | grep root) && rm /data/qcks/$f;
    done

    chown system:system $(realpath /dev/block/platform/msm_sdcc.1/by-name/m9kefs1)
    chmod 660 $(realpath /dev/block/platform/msm_sdcc.1/by-name/m9kefs1)
    chown system:system $(realpath /dev/block/platform/msm_sdcc.1/by-name/m9kefs2)
    chmod 660 $(realpath /dev/block/platform/msm_sdcc.1/by-name/m9kefs2)
    chown system:system $(realpath /dev/block/platform/msm_sdcc.1/by-name/m9kefs3)
    chmod 660 $(realpath /dev/block/platform/msm_sdcc.1/by-name/m9kefs3)

    echo 1 > /sys/module/rmnet_usb/parameters/rmnet_data_init

    setprop gsm.radio.kickstart on
fi
