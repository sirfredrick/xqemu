#!/bin/bash

set -e # exit if a command fails
set -x # Print commands
set -o pipefail # Will return the exit status of make if it fails

./configure \
	--python=python2 \
	--enable-debug \
	--extra-cflags="-g -O0 -Wno-error -DXBOX=1" \
	--target-list=i386-softmmu \
	--enable-sdl \
	--disable-cocoa \
	--with-sdlabi=2.0 \
	--disable-curl \
	--disable-vnc \
	--disable-docs \
	--disable-tools \
	--disable-guest-agent \
	--disable-tpm \
	--disable-live-block-migration \
	--disable-replication \
	--disable-capstone \
	--disable-fdt \
	--disable-libiscsi \
	--disable-spice \
	--disable-user \
	--disable-opengl \

time make -j4 2>&1 | tee build.log

mkdir -p dist
cp i386-softmmu/qemu-system-i386.exe dist/xqemu.exe
cp i386-softmmu/qemu-system-i386w.exe dist/xqemuw.exe
python2 ./get_deps.py dist/xqemu.exe dist
strip dist/xqemu.exe
strip dist/xqemuw.exe
