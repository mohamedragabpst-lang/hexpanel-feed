#!/bin/sh
# HexPanel installer: E2-DarkOS.openpli101
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/E2-DarkOS.openpli101.tar.gz"
SHA="d0e6c50027fd811da56ea548164c963e800fd51348ed8b071ee7278fba1cbde1"
DEST="/usr/share/enigma2"
NEED_KB=17928
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-E2-DarkOS.openpli101.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-E2-DarkOS.openpli101.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: E2-DarkOS.openpli101" || echo "Extract failed"
rm -f "$T"
