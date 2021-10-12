#!/bin/sh


echo "executing ./scripts/binderate.sh"

xamarin-android-binderator \
        --config=config.json 
        --basepath=./