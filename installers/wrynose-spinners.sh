#!/bin/sh
# HexPanel installer: wrynose-spinners
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/spinners/wrynose-spinners.tar.gz"
SHA="66a3be29e9d27824c489b39bc048aab0a7185b28dfde572cf7fac4426a210e3b"
DEST="/usr/share/enigma2"
NEED_KB=10303
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-wrynose-spinners.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-wrynose-spinners.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: wrynose-spinners" || echo "Extract failed"
rm -f "$T"
