#!/bin/sh
# HexPanel installer: FullHDLine.zukon
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/FullHDLine.zukon.tar.gz"
SHA="586e2cef014ebeb428faa956c5492190497f485dd19d1b6d722f61e34c0b3f87"
DEST="/usr/share/enigma2"
NEED_KB=26612
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-FullHDLine.zukon.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-FullHDLine.zukon.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: FullHDLine.zukon" || echo "Extract failed"
rm -f "$T"
