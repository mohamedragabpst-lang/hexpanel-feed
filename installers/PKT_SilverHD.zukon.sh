#!/bin/sh
# HexPanel installer: PKT_SilverHD.zukon
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/PKT_SilverHD.zukon.tar.gz"
SHA="b85c7ac13dfd6190442c64a40a855f07199977feb4cc16bc3058b0b553662b6d"
DEST="/usr/share/enigma2"
NEED_KB=14012
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-PKT_SilverHD.zukon.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-PKT_SilverHD.zukon.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: PKT_SilverHD.zukon" || echo "Extract failed"
rm -f "$T"
