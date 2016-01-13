#!/usr/bin/sh
wget -nc http://dl.nwjs.io/v0.13.0-beta3/nwjs-v0.13.0-beta3-linux-x64.tar.gz
tar -xvsf nwjs-v0.13.0-beta3-linux-x64.tar.gz
cd src
../nwjs-v0.13.0-beta3-linux-x64/nw .
