#!/bin/sh
# HexPanel installer: novaler-picons-union-part7of7
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/picons/novaler-picons-union-part7of7.tar.gz"
SHA="b5f27eb895487b0184ea62eb1cf0eb589418645ec042fa4ea67f8ee96caf6573"
DEST="/usr/share/enigma2/picon"
NEED_KB=41790
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-novaler-picons-union-part7of7.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-novaler-picons-union-part7of7.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: novaler-picons-union-part7of7" || echo "Extract failed"
rm -f "$T"
