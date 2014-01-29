#!/bin/bash
adb root
adb shell "echo 'network={
        ssid=\"$WIFI_SSID\"
        psk=\"$WIFI_PASSWORD\"
        key_mgmt=WPA-PSK
        priority=1
}' >> /data/misc/wifi/wpa_supplicant.conf"
adb reboot