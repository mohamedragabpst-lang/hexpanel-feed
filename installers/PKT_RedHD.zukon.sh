#!/bin/sh
# HexPanel installer: PKT_RedHD.zukon
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/zukon/PKT_RedHD.tar.gz"
SHA="5e536bc4018d6f7465bf821aff4ab80ae5edd194c17e650a2fcf54a3013fbcb8"
DEST="/usr/share/enigma2"
NEED_KB=10599
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-PKT_RedHD.zukon.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-PKT_RedHD.zukon.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: PKT_RedHD.zukon" || echo "Extract failed"
rm -f "$T"
