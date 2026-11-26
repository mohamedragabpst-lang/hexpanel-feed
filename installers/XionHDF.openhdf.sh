#!/bin/sh
# HexPanel installer: XionHDF.openhdf
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/XionHDF.openhdf.tar.gz"
SHA="3e4fae0511f38adadd1d37f5f9c5937983cc459379b451d621f76268dd76db2e"
DEST="/usr/share/enigma2"
NEED_KB=15205
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-XionHDF.openhdf.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-XionHDF.openhdf.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: XionHDF.openhdf" || echo "Extract failed"
rm -f "$T"
