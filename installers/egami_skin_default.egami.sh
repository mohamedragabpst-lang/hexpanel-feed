#!/bin/sh
# HexPanel installer: egami_skin_default.egami
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/egami_skin_default.egami.tar.gz"
SHA="96266b131f7e17bf6d27cec8d8e0b4bc5be44266996e34a276680c53f4e19ffc"
DEST="/usr/share/enigma2"
NEED_KB=10297
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-egami_skin_default.egami.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-egami_skin_default.egami.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: egami_skin_default.egami" || echo "Extract failed"
rm -f "$T"
