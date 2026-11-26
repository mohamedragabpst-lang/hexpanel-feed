#!/bin/sh
# HexPanel installer: openbh-channel-list
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/channels/openbh-channel-list.tar.gz"
SHA="10d2ee2c2f791af103f7780a99f7dcfa9b72f8ad92a2c862234cd2336e7e4fb8"
DEST="/etc/enigma2"
NEED_KB=11064
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openbh-channel-list.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openbh-channel-list.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openbh-channel-list" || echo "Extract failed"
rm -f "$T"
