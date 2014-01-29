#!/bin/bash

# PARAMETERS ---------------------------

LABEL="$DEPLOYMENT_CODE-$1"
TUNNEL_PORT="$TUNNEL_PORT_PREFIX$1"
SDCARD_INT="/data/media/0"
SDCARD_INT_ESCAPED="\/data\/media\/0"

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

cat ./devices/$DEVICE/openrecoveryscript.template | sed "s/SDCARD_INT/$SDCARD_INT_ESCAPED/g" | sed "s/LABEL/$LABEL/g" | sed "s/VERSION/$VERSION/g" | sed "s/TUNNEL_PORT/$TUNNEL_PORT/g" > ./devices/$DEVICE/openrecoveryscript

read -p "Press [Enter] key to start Flash..."

heimdall flash --no-reboot --RECOVERY  ./sdcard-ext/gt_p3113-twrp-2.6.3.0.img

read -p "Press [Enter] key when in TRWP recovery ..."

sleep 5
adb shell 'mkdir -p "$SDCARD_INT/sdcard-ext"'

adb push ./sdcard-ext/cm "$SDCARD_INT/sdcard-ext/cm"
adb push "./sdcard-ext/$VERSION" "$SDCARD_INT/sdcard-ext/$VERSION"
adb push ./devices/$DEVICE/openrecoveryscript /cache/recovery

sleep 3
adb reboot recovery

echo "Deploy Script Complete. OK To disconnect tablet."