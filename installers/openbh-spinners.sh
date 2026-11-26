#!/bin/sh
# HexPanel installer: openbh-spinners
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/spinners/openbh-spinners.tar.gz"
SHA="5bb7f820be74b2839d6276f330192aa2fd6e31388af1567bba4e9d1100e6e2a6"
DEST="/usr/share/enigma2"
NEED_KB=10407
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openbh-spinners.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openbh-spinners.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openbh-spinners" || echo "Extract failed"
rm -f "$T"
