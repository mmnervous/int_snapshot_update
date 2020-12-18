# Blockchain snapshot

SNAPSHOT="https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz"

echo -n "Did you stop intchain? (y/n)? Last update Fri 18 Dec 2020 01:35 PM CET"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
			rm -rf /tmp/intchain*
			echo "Downloading blockchain snapshot from $SNAPSHOT"
			wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
			rm -rf "${HOME}/.intchain/"
			mkdir -p "${HOME}/.intchain/"
			echo "Extracting '/tmp/intchainData-20201217.tar.gz' to '${HOME}/.intchain/'"
			tar -C "${HOME}/.intchain/" -xzvf "/tmp/intchainData-20201217.tar.gz" --strip-components 1 > ~/return.log
			echo "Almost done is not done. But this is the end of this script. If you see this message it means -"
else
    exit
fi
