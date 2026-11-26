#!/bin/sh
# HexPanel installer: Aglare-FHD-PLI.corvoboys
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/Aglare-FHD-PLI.corvoboys.tar.gz"
SHA="55bd2c1f4425b6176cd4a43cf979e30eca5cbc363407c09c0587530d5cda4801"
DEST="/usr/share/enigma2"
NEED_KB=49853
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-Aglare-FHD-PLI.corvoboys.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-Aglare-FHD-PLI.corvoboys.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: Aglare-FHD-PLI.corvoboys" || echo "Extract failed"
rm -f "$T"
