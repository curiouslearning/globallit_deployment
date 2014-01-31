#!/bin/bash
source ./deployment/$1/setup.sh
./devices/$DEVICE/deploy.sh $2