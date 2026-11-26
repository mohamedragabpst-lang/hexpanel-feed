#!/bin/sh
# HexPanel installer: BlackHarmony.zukon
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/BlackHarmony.zukon.tar.gz"
SHA="1a629eef3e9e54cf2abeef678f8d734b105f62ee97087056685fa73ed2f2a547"
DEST="/usr/share/enigma2"
NEED_KB=56477
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-BlackHarmony.zukon.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-BlackHarmony.zukon.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: BlackHarmony.zukon" || echo "Extract failed"
rm -f "$T"
