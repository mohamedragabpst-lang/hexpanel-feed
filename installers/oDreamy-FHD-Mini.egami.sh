#!/bin/sh
# HexPanel installer: oDreamy-FHD-Mini.egami
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/egami/oDreamy-FHD-Mini.tar.gz"
SHA="f4bcd1240a66a4f74682f04a1ef0c37ef7816a911202a55629084c69a5b51604"
DEST="/usr/share/enigma2"
NEED_KB=10733
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-oDreamy-FHD-Mini.egami.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-oDreamy-FHD-Mini.egami.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: oDreamy-FHD-Mini.egami" || echo "Extract failed"
rm -f "$T"
