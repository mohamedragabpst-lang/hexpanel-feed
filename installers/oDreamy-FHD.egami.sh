#!/bin/sh
# HexPanel installer: oDreamy-FHD.egami
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/oDreamy-FHD.egami.tar.gz"
SHA="455de5d779184349e15ad4cb54c4ff177308c48fa8dc77f5e2cdc5fa402dbd9c"
DEST="/usr/share/enigma2"
NEED_KB=18283
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-oDreamy-FHD.egami.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-oDreamy-FHD.egami.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: oDreamy-FHD.egami" || echo "Extract failed"
rm -f "$T"
