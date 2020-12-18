# Blockchain snapshot

SNAPSHOT="https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz"

while true; do
	read -p "Did you stop intchain?" yn
	case $yn in
		[Yy]* )
			rm -rf /tmp/intchain*
			echo "Downloading blockchain snapshot from $SNAPSHOT"
			wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
			rm -rf "${HOME}/.intchain/"
			mkdir -p "${HOME}/.intchain/"
			echo "Extracting '/tmp/intchainData-20201217.tar.gz' to '${HOME}/.intchain/'"
			tar -C "${HOME}/.intchain/" -xzvf "/tmp/intchainData-20201217.tar.gz" --strip-components 1 > ~/return.log
			echo "Almost done is not done. But this is the end of this script. If you see this message it means -"
			;;
		[Nn]* ) exit;;
		* ) echo "Please answer yes or no.";;
	esac
done
