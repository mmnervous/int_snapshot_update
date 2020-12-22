# Blockchain snapshot

SNAPSHOT="http://shaiiko.com/mmch_intchainData-20201222.tar.gz"
SNAPSHOT_1="http://shaiiko.com/intchainData-20201217.tar.gz"
SNAPSHOT_2="https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz"
FILE=/tmp/intchainData-20201217.tar.gz

echo "Last update Fri 22 Dec 2020 8:26 AM CET"
echo -n "Did you stop intchain? (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
			echo -n "Start download (y/n)? "
			read answer
			if [ "$answer" != "${answer#[Yy]}" ] ;then
				rm -rf /tmp/*intchain*
				echo "Downloading blockchain snapshot from $SNAPSHOT"
				wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
			fi
			echo -n "Start extraction (y/n)? "
			read answer
			if [ "$answer" != "${answer#[Yy]}" ] ;then
				if [ -f "$FILE" ]; then
					echo "$FILE exists."
					rm -rf "${HOME}/.intchain/"
					mkdir -p "${HOME}/.intchain/"
					echo "Extracting '/tmp/mmch_intchainData-20201217.tar.gz' to '${HOME}/.intchain/'"
					tar -C "${HOME}/.intchain/" -xzvf "/tmp/mmch_intchainData-20201217.tar.gz" --strip-components 1 2>&1 |
					while read line; do
						x=$((x+1))
						echo -en "$x extracted\r"
					done
					echo "Extraction done !"
				else
					echo "$FILE does not exist. You have to download it."
				fi
			fi
else
	echo "You have to stop intchain first"
	exit
fi
