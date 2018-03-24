#
#make the Cracked directory if it doesn't exist
#

echo "***You need "zip", "unzip," and "Link Identity Editor (ldid)" installed from Cydia to begin"

if [ ! -f /usr/bin/ldid || ! -f /usr/bin/zip || ! -f /usr/bin/unzip]; then
echo "Exiting, one or more of the required programs is missing"
exit
fi


DIRECTORY=/var/mobile/Documents/Cracked/
if [ ! -d "$DIRECTORY" ]; then
mkdir /var/mobile/Documents/Cracked/
fi



CURRENTDIR=/var/mobile/Documents/Cracked/
IPA="$*"
echo Attempting to unzip .ipa
unzip "$IPA"
cd Payload
NAME=$(ls -1)
EXECUTABLE=${NAME%.app}
cd "$(ls -1)"
ldid -S "$EXECUTABLE"
cd ..
cd ..
zip -r "$EXECUTABLE".ipa Payload
rm -r Payload
echo "[*]Generated signed .ipa in $(pwd)/"$EXECUTABLE".ipa"
