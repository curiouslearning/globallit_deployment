#!/bin/bash

# PARAMETERS ---------------------------

LABEL="$DEPLOYMENT_CODE-$1-$2"
TUNNEL_PORT="$TUNNEL_PORT_PREFIX$2"
SDCARD_INT="/data/media/0"
SDCARD_INT_ESCAPED="\/data\/media\/0"
SDCARD_EXT="/sdcard"
SDCARD_EXT_ESCAPED="\/sdcard"

# --------------------------------------

if [[ $# -lt 1 ]] ; then
    echo 'This script requires an argument: TABLET_ID'
    exit 0
fi

echo "Installing Version: $VERSION"
echo "Tablet: $LABEL"
echo "Tunnel Port: $TUNNEL_PORT"
if [ -n "$WIFI_SSID" ]
then
  echo "WIFI_SSID: $WIFI_SSID"
else
  echo "No WIFI setup supplied."
fi     # $String is null.

cat ./devices/$DEVICE/openrecoveryscript.template | sed "s/CYANOGENMOD/$CYANOGENMOD/g" |sed "s/SDCARD_EXT/$SDCARD_EXT_ESCAPED/g" | sed "s/SDCARD_INT/$SDCARD_INT_ESCAPED/g" | sed "s/LABEL/$LABEL/g" | sed "s/VERSION/$VERSION/g" | sed "s/TUNNEL_PORT/$TUNNEL_PORT/g" | sed "s/WIFI_SSID/$WIFI_SSID/g" | sed "s/WIFI_PASSWORD/$WIFI_PASSWORD/g"  > ./devices/$DEVICE/openrecoveryscript

read -p "Press [Enter] key to start Flash..."

adb reboot bootloader
sleep 15
fastboot flash recovery ./deployment/$DEPLOYMENT_CODE/$TWRP
fastboot reboot
sleep 60
adb reboot recovery
read -p "Press [Enter] key when in TRWP recovery (menu grid appears)..."
adb push ./devices/$DEVICE/openrecoveryscript /cache/recovery
adb reboot recovery


# sleep 5
# adb shell 'mkdir -p "$SDCARD_INT/sdcard-ext"'

# adb push ./sdcard-ext/cm "$SDCARD_INT/sdcard-ext/cm"
# adb push "./sdcard-ext/$VERSION" "$SDCARD_INT/sdcard-ext/$VERSION"
# adb push ./devices/$DEVICE/openrecoveryscript /cache/recovery

# sleep 3
# adb reboot recovery

# echo "Deploy Script Complete. OK To disconnect tablet."