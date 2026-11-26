#!/bin/sh
# HexPanel installer: OctEtFHD.openspa
URL="https://github.com/mohamedragabpst-lang/hexpanel-feed/releases/download/content-v1/skins/openspa/OctEtFHD.tar.gz"
SHA="abf666643a8a491dceb7a0873d015027389d2edcb084574ea1426795d55aae30"
DEST="/usr/share/enigma2"
NEED_KB=14378
T=""
for d in /media/hdd /media/usb /media/sda1 /media/sdb1 /tmp; do
  [ -d "$d" ] && [ -w "$d" ] || continue
  free=$(df -k "$d" | awk 'NR==2{print $4}')
  if [ -n "$free" ] && [ "$free" -gt "$NEED_KB" ]; then T="$d/hexpanel-OctEtFHD.openspa.sh.tar.gz"; break; fi
done
[ -z "$T" ] && T=/tmp/hexpanel-OctEtFHD.openspa.sh.tar.gz
wget -q --no-check-certificate -O "$T" "$URL" || { echo "Download failed"; exit 1; }
echo "$SHA  $T" | sha256sum -c - || { echo "Checksum failed"; rm -f "$T"; exit 1; }
mkdir -p "$DEST" && tar -xzf "$T" -C "$DEST" && echo "Installed: OctEtFHD.openspa" || echo "Extract failed"
rm -f "$T"
