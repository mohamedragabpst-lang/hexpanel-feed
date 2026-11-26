#!/bin/sh
# HexPanel installer: DarkFHD.zukon
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/zukon/DarkFHD.tar.gz"
SHA="6497e92eb9db0911bb20982e26c5eac0b65c336f8563b8bd9fec8ee94e591371"
DEST="/usr/share/enigma2"
NEED_KB=17063
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-DarkFHD.zukon.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-DarkFHD.zukon.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: DarkFHD.zukon" || echo "Extract failed"
rm -f "$T"
