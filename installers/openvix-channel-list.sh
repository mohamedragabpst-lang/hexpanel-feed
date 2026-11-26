#!/bin/sh
# HexPanel installer: openvix-channel-list
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/channels/openvix-channel-list.tar.gz"
SHA="53e8b6248694e1e0d047d0693d94a77968e657ea7fabef7a330be71fcdc22ad1"
DEST="/etc/enigma2"
NEED_KB=11063
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openvix-channel-list.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openvix-channel-list.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openvix-channel-list" || echo "Extract failed"
rm -f "$T"
