#!/bin/sh
# HexPanel installer: Aglare-FHD-PLI.openvix
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/openvix/Aglare-FHD-PLI.tar.gz"
SHA="43f009afc40a279de3beda94272a3f612180f06bf4db6e7a4b7ec42803606a64"
DEST="/usr/share/enigma2"
NEED_KB=28799
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-Aglare-FHD-PLI.openvix.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-Aglare-FHD-PLI.openvix.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: Aglare-FHD-PLI.openvix" || echo "Extract failed"
rm -f "$T"
