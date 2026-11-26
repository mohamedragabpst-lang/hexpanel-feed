#!/bin/sh
# HexPanel installer: Aglare-FHD-PLI.wrynose
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/Aglare-FHD-PLI.wrynose.tar.gz"
SHA="7c64933416ae4ddad798ee366eebe128ad067bfe559f1a41b77f59408a1c26eb"
DEST="/usr/share/enigma2"
NEED_KB=26504
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-Aglare-FHD-PLI.wrynose.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-Aglare-FHD-PLI.wrynose.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: Aglare-FHD-PLI.wrynose" || echo "Extract failed"
rm -f "$T"
