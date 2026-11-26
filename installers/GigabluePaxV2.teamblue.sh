#!/bin/sh
# HexPanel installer: GigabluePaxV2.teamblue
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/teamblue/GigabluePaxV2.tar.gz"
SHA="bd1880a34a944d3a0ff2ed2e4345e5caa486f88a3127d9dfeea209e5fdf9f9a7"
DEST="/usr/share/enigma2"
NEED_KB=27081
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-GigabluePaxV2.teamblue.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-GigabluePaxV2.teamblue.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: GigabluePaxV2.teamblue" || echo "Extract failed"
rm -f "$T"
