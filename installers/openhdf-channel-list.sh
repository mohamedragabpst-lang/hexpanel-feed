#!/bin/sh
# HexPanel installer: openhdf-channel-list
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/channels/openhdf-channel-list.tar.gz"
SHA="b3564b4580bce9ed9f7707afe2a1f632f9457c7262af361248d31a1815eace72"
DEST="/etc/enigma2"
NEED_KB=11027
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openhdf-channel-list.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openhdf-channel-list.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openhdf-channel-list" || echo "Extract failed"
rm -f "$T"
