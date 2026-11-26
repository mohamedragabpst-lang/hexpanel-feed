#!/bin/sh
# HexPanel installer: MX_SilverLight_P.openbh
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/openbh/MX_SilverLight_P.tar.gz"
SHA="fd2f6e4040e07acb2576d79d31d575d29735c62149fe8842f17f793deeef980a"
DEST="/usr/share/enigma2"
NEED_KB=13522
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-MX_SilverLight_P.openbh.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-MX_SilverLight_P.openbh.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: MX_SilverLight_P.openbh" || echo "Extract failed"
rm -f "$T"
