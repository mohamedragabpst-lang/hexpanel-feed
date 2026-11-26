#!/bin/sh
# HexPanel installer: openvix-bootlogos
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/openvix-bootlogos.tar.gz"
SHA="ea2d933d3c77f0f514597e0ae07f560a0cc07972588482b829616acddc9c07d3"
DEST="/"
NEED_KB=12740
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openvix-bootlogos.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openvix-bootlogos.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openvix-bootlogos" || echo "Extract failed"
rm -f "$T"
