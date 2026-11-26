#!/bin/sh
# HexPanel installer: E2-DarkOS.wrynose
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/wrynose/E2-DarkOS.tar.gz"
SHA="3e98316a78f2f8a0fd75cdb7b1e879566fef0de58865aef060a095ed8bcc141b"
DEST="/usr/share/enigma2"
NEED_KB=17933
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-E2-DarkOS.wrynose.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-E2-DarkOS.wrynose.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: E2-DarkOS.wrynose" || echo "Extract failed"
rm -f "$T"
