#!/bin/bash
#written by mistfire
#helper make all jack apps connect to pipewire by default

TARGET_DIR="/usr/local/lib/x86_64-linux-gnu"
PIPEWIRE_JACK_DIR="/usr/lib/x86_64-linux-gnu/pipewire-0.3/jack"

PWJACK_LIBS="libjack.so libjack.so.0 libjacknet.so libjacknet.so.0 libjackserver.so libjackserver.so.0"

[ ! -d "$PIPEWIRE_JACK_DIR" ] && exit 0
[ ! -d "$TARGET_DIR" ] && mkdir -p "$TARGET_DIR"

for JCKLIB in $PWJACK_LIBS
do
 
 if [ -f "${PIPEWIRE_JACK_DIR}/${JCKLIB}" ]; then
    [ ! -f "${TARGET_DIR}/${JCKLIB}" ] && ln -s "${PIPEWIRE_JACK_DIR}/${JCKLIB}" "${TARGET_DIR}/${JCKLIB}"
 fi
 
done

exit 0
