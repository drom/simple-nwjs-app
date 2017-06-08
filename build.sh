#!/bin/bash

set -e

NWVERSION="v0.23.1"
V="v1.0.0"
N="simpleapp"
PREFIX=""

# command line arguments
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
  -n|--name)
  N="$2"
  shift
  ;;
  -p|--prefix)
  PREFIX="$2"
  shift
  ;;
  -w|--nwversion)
  NWVERSION="$2"
  shift
  ;;
  -v|--version)
  V="$2"
  shift
  ;;
  *)
  ;;
esac
shift
done

URL="http://dl.nwjs.io/"$NWVERSION
NWV=$PREFIX$NWVERSION

urlget() {
    if ! [ -f "$2" ]; then
        if hash wget 2>/dev/null; then
            wget "$1" -O "$2"
        elif hash curl 2>/dev/null; then
            curl "$1" -o "$2"
        else
            echo "wget or curl must be installed."
            exit 1
        fi
    fi
}

mkdir -p build

rm -rf build/*

# make app
pushd src && zip -r ../build/"$N"-$V.nw * && popd

mkdir -p cache
rm -rf cache/*/*

# get and unpack NWJS packages
for P in linux-x64 linux-ia32
do
  urlget $URL/nwjs-$NWV-$P.tar.gz cache/nwjs-$NWV-$P.tar.gz
  tar -xvf cache/nwjs-$NWV-$P.tar.gz -C cache
done

for P in win-x64 win-ia32 osx-x64
do
  urlget $URL/nwjs-$NWV-$P.zip cache/nwjs-$NWV-$P.zip
  unzip -d cache/ -o cache/nwjs-$NWV-$P.zip
done

# clean cache
for P in linux-x64 linux-ia32 win-x64 win-ia32 osx-x64
do
  mkdir -p cache/"$N"-$V-$P
  rm -rf cache/"$N"-$V-$P/*
  cp -R cache/nwjs-$NWV-$P/* cache/"$N"-$V-$P
done

# pack APP packages
for P in linux-x64 linux-ia32
do
  cat cache/"$N"-$V-$P/nw build/"$N"-$V.nw > cache/"$N"-$V-$P/"$N"
  chmod +x cache/"$N"-$V-$P/"$N"
  rm  cache/"$N"-$V-$P/nw
  pushd cache && tar -cvzf ../build/"$N"-$V-$P.tar.gz "$N"-$V-$P/* && popd
done

for P in win-x64 win-ia32
do
  cat cache/"$N"-$V-$P/nw.exe build/"$N"-$V.nw > cache/"$N"-$V-$P/"$N".exe
  rm  cache/"$N"-$V-$P/nw.exe
  pushd cache && zip -r ../build/"$N"-$V-$P.zip "$N"-$V-$P/* && popd
done

for P in osx-x64
do
  cp build/"$N"-$V.nw cache/"$N"-$V-$P/nwjs.app/Contents/Resources/app.nw
  mv cache/"$N"-$V-$P/nwjs.app cache/"$N"-$V-$P/"$N".app
  pushd cache && zip -r ../build/"$N"-$V-$P.zip "$N"-$V-$P/* && popd
done

echo "cache area:"
ls -l cache

echo "build area:"
ls -l build
