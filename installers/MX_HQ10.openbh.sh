#!/bin/sh
# HexPanel installer: MX_HQ10.openbh
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/MX_HQ10.openbh.tar.gz"
SHA="fa7e8f99641111f0c1fbf05c3717615492e309051433110d03ca961f4d19a467"
DEST="/usr/share/enigma2"
NEED_KB=14061
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-MX_HQ10.openbh.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-MX_HQ10.openbh.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: MX_HQ10.openbh" || echo "Extract failed"
rm -f "$T"
