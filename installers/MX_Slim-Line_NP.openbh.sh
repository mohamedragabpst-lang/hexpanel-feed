#!/bin/sh
# HexPanel installer: MX_Slim-Line_NP.openbh
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/openbh/MX_Slim-Line_NP.tar.gz"
SHA="8d968ba3f8aa0db712f6ee87dd556629c9671f2da97f3a0e2f285da182e6d6d0"
DEST="/usr/share/enigma2"
NEED_KB=14858
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-MX_Slim-Line_NP.openbh.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-MX_Slim-Line_NP.openbh.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: MX_Slim-Line_NP.openbh" || echo "Extract failed"
rm -f "$T"
