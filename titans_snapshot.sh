# Blockchain snapshot

SNAPSHOT="http://shaiiko.com/intchainData-20201217.tar.gz"
SNAPSHOT_2="https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz"

echo "Last update Fri 20 Dec 2020 03:52 PM CET"
echo -n "Did you stop intchain? (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
			echo -n "Start download (y/n)? "
			read answer
			if [ "$answer" != "${answer#[Yy]}" ] ;then
				rm -rf /tmp/intchain*
				echo "Downloading blockchain snapshot from $SNAPSHOT"
				wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
			fi
			echo -n "Start extraction (y/n)? "
			read answer
			if [ "$answer" != "${answer#[Yy]}" ] ;then
				rm -rf "${HOME}/.intchain/"
				mkdir -p "${HOME}/.intchain/"
				echo "Extracting '/tmp/intchainData-20201217.tar.gz' to '${HOME}/.intchain/'"
				tar -C "${HOME}/.intchain/" -xzvf "/tmp/intchainData-20201217.tar.gz" --strip-components 1 2>&1 |
				while read line; do
					x=$((x+1))
					echo -en "$x extracted\r"
				done
				echo "Almost done is not done. But this is the end of this script. If you see this message it means -"
			fi
else
	echo "You have to stop intchain first"
	exit
fi
