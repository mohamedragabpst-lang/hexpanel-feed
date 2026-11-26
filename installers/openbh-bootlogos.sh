#!/bin/sh
# HexPanel installer: openbh-bootlogos
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/bootlogos/openbh-bootlogos.tar.gz"
SHA="120fb8a432c896eead97bd52259c2d810674ed4639e89385df20ac843c85d7e6"
DEST="/"
NEED_KB=12242
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openbh-bootlogos.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openbh-bootlogos.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openbh-bootlogos" || echo "Extract failed"
rm -f "$T"
