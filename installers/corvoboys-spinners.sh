#!/bin/sh
# HexPanel installer: corvoboys-spinners
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/spinners/corvoboys-spinners.tar.gz"
SHA="53dd352434c46ec9d46218f0e438797141904e4eb8c41df30bec48cc51f48423"
DEST="/usr/share/enigma2"
NEED_KB=10284
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-corvoboys-spinners.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-corvoboys-spinners.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: corvoboys-spinners" || echo "Extract failed"
rm -f "$T"
