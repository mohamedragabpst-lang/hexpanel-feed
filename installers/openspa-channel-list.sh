#!/bin/sh
# HexPanel installer: openspa-channel-list
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/channels/openspa-channel-list.tar.gz"
SHA="2a09837322d347346da5553bd078ba3d3cae3cef47918aa861dec2b59c47ba35"
DEST="/etc/enigma2"
NEED_KB=11014
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-openspa-channel-list.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-openspa-channel-list.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: openspa-channel-list" || echo "Extract failed"
rm -f "$T"
