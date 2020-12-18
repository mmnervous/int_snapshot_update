# Blockchain snapshot

SNAPSHOT="https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz"

rm -rf /tmp/intchain*
echo "Downloading blockchain snapshot from $SNAPSHOT"
wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
rm -rf "${HOME}/.intchain/"
mkdir -p "${HOME}/.intchain/"
echo "Extracting '/tmp/intchainData-20201217.tar.gz' to '${HOME}/.intchain/'"
tar -C "${HOME}/.intchain/" -xzvf "/tmp/intchainData-20201217.tar.gz" --strip-components 1 > ~/return.log
echo "end"
