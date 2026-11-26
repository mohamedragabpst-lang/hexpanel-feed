#!/bin/sh
# HexPanel installer: teamblue-bootlogos
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/teamblue-bootlogos.tar.gz"
SHA="2ba6b52346d4853a1b22c3cd2829aca7db6fb81760e86ee44cab332ae55b7423"
DEST="/"
NEED_KB=11482
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-teamblue-bootlogos.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-teamblue-bootlogos.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: teamblue-bootlogos" || echo "Extract failed"
rm -f "$T"
