#!/bin/sh
# HexPanel installer: ViXBMC_1080_Bello.openvix
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/ViXBMC_1080_Bello.openvix.tar.gz"
SHA="d84b90c545ead1245ea8d44563b0b6d1484f103258da2b1882f56db3e5f1109f"
DEST="/usr/share/enigma2"
NEED_KB=19673
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-ViXBMC_1080_Bello.openvix.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-ViXBMC_1080_Bello.openvix.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: ViXBMC_1080_Bello.openvix" || echo "Extract failed"
rm -f "$T"
