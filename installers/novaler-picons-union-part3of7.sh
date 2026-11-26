#!/bin/sh
# HexPanel installer: novaler-picons-union-part3of7
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/picons/novaler-picons-union-part3of7.tar.gz"
SHA="0da6451dd9e0637bf5a98f37ce5e5e506d9154ff4462f72c9e5071ba416ba992"
DEST="/usr/share/enigma2/picon"
NEED_KB=37052
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-novaler-picons-union-part3of7.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-novaler-picons-union-part3of7.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: novaler-picons-union-part3of7" || echo "Extract failed"
rm -f "$T"
