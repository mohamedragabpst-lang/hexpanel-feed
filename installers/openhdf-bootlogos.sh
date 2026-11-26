#!/bin/sh
# HexPanel installer: openhdf-bootlogos
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/bootlogos/openhdf-bootlogos.tar.gz"
SHA="99cd4456441eb487374f88f5b9fd9af5e0a64bc9e1307da813e0f805e71b9fce"
DEST="/"
NEED_KB=11380
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openhdf-bootlogos.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openhdf-bootlogos.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openhdf-bootlogos" || echo "Extract failed"
rm -f "$T"
