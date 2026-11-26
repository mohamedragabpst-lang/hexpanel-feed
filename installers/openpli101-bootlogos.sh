#!/bin/sh
# HexPanel installer: openpli101-bootlogos
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/bootlogos/openpli101-bootlogos.tar.gz"
SHA="bf26765a765c96364b83ba1606a5a4208bee4d4b2bd753a0b582f7da22444c27"
DEST="/"
NEED_KB=11186
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openpli101-bootlogos.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openpli101-bootlogos.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openpli101-bootlogos" || echo "Extract failed"
rm -f "$T"
