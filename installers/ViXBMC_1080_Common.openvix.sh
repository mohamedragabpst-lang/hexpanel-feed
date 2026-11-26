#!/bin/sh
# HexPanel installer: ViXBMC_1080_Common.openvix
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/ViXBMC_1080_Common.openvix.tar.gz"
SHA="a8326359ddd36430e0dc9713284d56c31052a3ac50f3179120f5c522dd0deade"
DEST="/usr/share/enigma2"
NEED_KB=13342
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-ViXBMC_1080_Common.openvix.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-ViXBMC_1080_Common.openvix.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: ViXBMC_1080_Common.openvix" || echo "Extract failed"
rm -f "$T"
