#!/bin/bash

paxctl -C Appstore
paxctl -pemxr Appstore
cp -f Appstore /media/arcelik/ROOTFS/root/.

../../printhash/printhash Appstore
gedit /media/arcelik/ROOTFS/etc/appmand/14.mf
