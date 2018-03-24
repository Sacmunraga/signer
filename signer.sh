if [[ $EUID -ne 0 ]]; then
echo "This script must be run as root"
exit 1
fi
echo "Usage: bash signer.sh ipaname.ipa"

if [ ! -f /usr/bin/ldid ] || [ ! -f /usr/bin/zip ] || [ ! -f /usr/bin/unzip ]; then
echo "***You need "'zip'", "'unzip,'" and "'Link Identity Editor (ldid)'" installed from Cydia to begin***"
echo "Exiting, one or more of the required programs is missing"
exit
fi

if [$1 == ""]; then
echo "You didn't specify an argument (ipa file), try again."
exit
fi



makeTheDir () {
DIRECTORY=/var/mobile/Documents/signed/
if [ ! -d "$DIRECTORY" ]; then
mkdir /var/mobile/Documents/signed/
fi
}



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
echo "Do you want $EXECUTABLE.ipa to be placed in /var/mobile/Documents/signed (yes) or left in the current directory $(pwd) (no)? yes/no"
read answer
if [ "$answer" == "yes" ]; then
makeTheDir
cp "$EXECUTABLE".ipa /var/mobile/Documents/signed
rm "$EXECUTABLE".ipa
cd /var/mobile/Documents/signed
fi
echo "[*]Generated signed .ipa in $(pwd)/"$EXECUTABLE".ipa"
