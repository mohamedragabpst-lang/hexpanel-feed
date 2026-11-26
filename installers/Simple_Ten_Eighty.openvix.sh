#!/bin/sh
# HexPanel installer: Simple_Ten_Eighty.openvix
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/openvix/Simple_Ten_Eighty.tar.gz"
SHA="b7e3a9aba1aabd989053cef22bdd89c7bebe47ed40899089467b7b5b6b8578f1"
DEST="/usr/share/enigma2"
NEED_KB=12472
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-Simple_Ten_Eighty.openvix.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-Simple_Ten_Eighty.openvix.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: Simple_Ten_Eighty.openvix" || echo "Extract failed"
rm -f "$T"
