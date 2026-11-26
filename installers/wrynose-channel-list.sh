#!/bin/sh
# HexPanel installer: wrynose-channel-list
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/channels/wrynose-channel-list.tar.gz"
SHA="b112d1377be76d0da068f34b6e8a30ec29d48a39dff9437c7513ccddf61d3e79"
DEST="/etc/enigma2"
NEED_KB=11098
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-wrynose-channel-list.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-wrynose-channel-list.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: wrynose-channel-list" || echo "Extract failed"
rm -f "$T"
