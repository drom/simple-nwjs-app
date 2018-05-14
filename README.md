# simple nw app builder

[![Build Status](https://travis-ci.org/drom/simple-nwjs-app.svg?branch=master)](https://travis-ci.org/drom/simple-nwjs-app)

The BASH script `build.sh` that builds simple JS APP `src/` with [nwjs](http://nwjs.io) v0.30 for Linux/Mac/Windows desktops.

## Run Linux/MacOS

  * Put your NWJS APP into the `src/` folder.
  * Download & run script
```bash
wget https://raw.githubusercontent.com/drom/simple-nwjs-app/master/build.sh -O build.sh
bash build.sh --name myapp --version v1.2.3
```
  * Grab builds from the `build/` folder.

## Options

### -n, --name

App name

### -v, --version

App version

### -w, --nwversion

NWJS version

### -p, --prefix

NWJS prefix

  * sdk_symbol
  * sdk
  * symbol
  * ""
