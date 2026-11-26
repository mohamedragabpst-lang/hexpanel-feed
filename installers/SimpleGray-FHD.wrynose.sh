#!/bin/sh
# HexPanel installer: SimpleGray-FHD.wrynose
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/wrynose/SimpleGray-FHD.tar.gz"
SHA="65a8a5684c8aac1c6ab3917ccbe1fbe80804887471a82d0cbb7e6a6e9ee3971a"
DEST="/usr/share/enigma2"
NEED_KB=10658
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-SimpleGray-FHD.wrynose.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-SimpleGray-FHD.wrynose.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: SimpleGray-FHD.wrynose" || echo "Extract failed"
rm -f "$T"
