#!/bin/bash

if [ -f /usr/share/applications/gdebi.desktop ]; then

	if [ "$(grep "Exec=gdebi-gtk " /usr/share/applications/gdebi.desktop 2>/dev/null)" != "" ]; then
	  sed -i -e "s#Exec=gdebi-gtk\ #Exec=sudo\ -A\ gdebi-gtk\ #g" /usr/share/applications/gdebi.desktop
	fi

fi
