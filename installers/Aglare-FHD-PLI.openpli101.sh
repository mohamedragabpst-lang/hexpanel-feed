#!/bin/sh
# HexPanel installer: Aglare-FHD-PLI.openpli101
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/Aglare-FHD-PLI.openpli101.tar.gz"
SHA="7570cdf78054d653d1f6b357b713eb9468db39bd140a212e3494387bbb72b607"
DEST="/usr/share/enigma2"
NEED_KB=26325
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-Aglare-FHD-PLI.openpli101.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-Aglare-FHD-PLI.openpli101.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: Aglare-FHD-PLI.openpli101" || echo "Extract failed"
rm -f "$T"
