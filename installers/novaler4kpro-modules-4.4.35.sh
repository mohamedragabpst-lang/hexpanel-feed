#!/bin/sh
# HexPanel installer: novaler4kpro-modules-4.4.35
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/drivers/novaler4kpro-modules-4.4.35.tar.gz"
SHA="7a476e3d917bb650a72b45b7578c6711f23601755ba1110431babc95707f03e5"
DEST="/lib/modules"
NEED_KB=34535
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-novaler4kpro-modules-4.4.35.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-novaler4kpro-modules-4.4.35.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: novaler4kpro-modules-4.4.35" || echo "Extract failed"
rm -f "$T"
