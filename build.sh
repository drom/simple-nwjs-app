#!/bin/bash
URL="http://dl.nwjs.io/"
NWV="v0.17.0-beta2"
V="v1.0.0"
N="simpleapp"

mkdir build

rm -rf build/*

# making app
pushd src && zip -r ../build/$N-$V.nw * && popd

mkdir cache
rm -rf cache/*/*

for P in linux-x64 linux-x86
do
  wget -nc $URL$NWV/nwjs-$NWV-$P.tar.gz -O cache/nwjs-$NWV-$P.tar.gz
  tar -xvsf cache/nwjs-$NWV-$P.tar.gz -C cache/
done

for P in win-x64 win-x86 osx-x64
do
  wget -nc $URL$NWV/nwjs-$NWV-$P.zip -O cache/nwjs-$NWV-$P.zip
  unzip -d cache/ -o cache/nwjs-$NWV-$P.zip
done

for P in linux-x64 linux-x86 win-x64 win-x86 osx-x64
do
  mkdir cache/$N-$V-$P
  rm -rf cache/$N-$V-$P/*
  cp -R cache/nwjs-$NWV-$P/* cache/$N-$V-$P
done

for P in linux-x64 linux-x86
do
  cat cache/$N-$V-$P/nw build/$N-$V.nw > cache/$N-$V-$P/$N
  chmod +x cache/$N-$V-$P/$N
  rm  cache/$N-$V-$P/nw
  pushd cache && tar -cvzf ../build/$N-$V-$P.tar.gz $N-$V-$P/* && popd
done

for P in win-x64 win-x86
do
  cat cache/$N-$V-$P/nw.exe build/$N-$V.nw > cache/$N-$V-$P/$N.exe
  rm  cache/$N-$V-$P/nw.exe
  pushd cache && zip -r ../build/$N-$V-$P.zip $N-$V-$P/* && popd
done

for P in osx-x64
do
  cat cache/$N-$V-$P/nwjs.app/Contents/MacOS/nwjs \
  build/$N-$V.nw > cache/$N-$V-$P/nwjs.app/Contents/MacOS/$N
  rm  cache/$N-$V-$P/nwjs.app/Contents/MacOS/nwjs
  pushd cache && zip -r ../build/$N-$V-$P.zip $N-$V-$P/* && popd
done

echo "cache area:"
ls -l cache

echo "build area:"
ls -l build
