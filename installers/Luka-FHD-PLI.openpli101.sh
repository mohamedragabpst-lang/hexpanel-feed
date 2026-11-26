#!/bin/sh
# HexPanel installer: Luka-FHD-PLI.openpli101
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/openpli101/Luka-FHD-PLI.tar.gz"
SHA="cbdf71a4a9a5b8ac01901725545e8298d4a2c8fdfc8a24f91aa25fc135725e97"
DEST="/usr/share/enigma2"
NEED_KB=41594
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-Luka-FHD-PLI.openpli101.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-Luka-FHD-PLI.openpli101.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: Luka-FHD-PLI.openpli101" || echo "Extract failed"
rm -f "$T"
