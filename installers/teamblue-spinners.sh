#!/bin/sh
# HexPanel installer: teamblue-spinners
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/spinners/teamblue-spinners.tar.gz"
SHA="39223b9b752e89b75d02cc915ff61f70daa993b165d1c32b17407dd7a7f9f098"
DEST="/usr/share/enigma2"
NEED_KB=10249
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-teamblue-spinners.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-teamblue-spinners.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: teamblue-spinners" || echo "Extract failed"
rm -f "$T"
