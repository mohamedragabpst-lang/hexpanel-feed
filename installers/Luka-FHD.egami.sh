#!/bin/sh
# HexPanel installer: Luka-FHD.egami
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/egami/Luka-FHD.tar.gz"
SHA="1c19116b0913fd9e569ce2fc99d43a09203b26c17ced3aa8dd78e6e96c848517"
DEST="/usr/share/enigma2"
NEED_KB=39255
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-Luka-FHD.egami.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-Luka-FHD.egami.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: Luka-FHD.egami" || echo "Extract failed"
rm -f "$T"
