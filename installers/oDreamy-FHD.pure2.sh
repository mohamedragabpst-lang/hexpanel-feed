#!/bin/sh
# HexPanel installer: oDreamy-FHD.pure2
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/oDreamy-FHD.pure2.tar.gz"
SHA="9d5f1f333d290560f542ff0074ee5219646b36b1b30c0cbe577a4ecfc9ee16fd"
DEST="/usr/share/enigma2"
NEED_KB=32595
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-oDreamy-FHD.pure2.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-oDreamy-FHD.pure2.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: oDreamy-FHD.pure2" || echo "Extract failed"
rm -f "$T"
