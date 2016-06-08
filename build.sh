#!/usr/bin/sh
wget -nc http://dl.nwjs.io/v0.15.2/nwjs-v0.15.2-linux-x64.tar.gz
tar -xvsf nwjs-v0.15.2-linux-x64.tar.gz
cd src
../nwjs-v0.15.2-linux-x64/nw .
