#!/bin/sh
# HexPanel installer: pure2-spinners
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/spinners/pure2-spinners.tar.gz"
SHA="95b1002016b9c57488c05f487516dde7a436b7fc3897574a36bc64048efb2770"
DEST="/usr/share/enigma2"
NEED_KB=10264
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-pure2-spinners.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-pure2-spinners.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: pure2-spinners" || echo "Extract failed"
rm -f "$T"
