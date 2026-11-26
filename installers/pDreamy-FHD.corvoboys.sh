#!/bin/sh
# HexPanel installer: pDreamy-FHD.corvoboys
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/pDreamy-FHD.corvoboys.tar.gz"
SHA="c08b8564234d2a04fb4c8cac65ea245b5aa516bdd0a0d53d3033b404164df7a1"
DEST="/usr/share/enigma2"
NEED_KB=16788
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-pDreamy-FHD.corvoboys.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-pDreamy-FHD.corvoboys.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: pDreamy-FHD.corvoboys" || echo "Extract failed"
rm -f "$T"
