# Blockchain snapshot
# Snapshot 17th December http://shaiiko.com/intchainData-20201217.tar.gz
# Snapshot 17th December https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz
# tar -xvf ${backup_file} -C "/"

SNAPSHOT="http://shaiiko.com/mmch_825656_intchainData-20201222.tar.gz"

data_dir="${HOME}/.intchain"
backup_dir="${HOME}/backup"
backup_file="${backup_dir}/int_backup.tar"
FILE=/tmp/mmch_825656_intchainData-20201222.tar.gz

echo "Last update Fri 22 Dec 2020 3:13 PM CET"
echo -n "Did you stop intchain? (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
	# Download
	echo -n "Start download (y/n)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		rm -rf /tmp/*intchain*
		echo "Downloading blockchain snapshot from $SNAPSHOT"
		wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
	fi

	# Backup
	echo -n "Backup your files (y/n)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		mkdir -p backup
		rm -rf $backup_file
		tar -cvf "${backup_file}" $(find ${data_dir} -name "UTC*" -or -name "nodekey" -or -name "priv_validator.json")
	fi

	# Exctraction
	echo -n "Start extraction (y/n)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		if [ -f "$FILE" ]; then
			echo "$FILE exists."
			rm -rf "${HOME}/.intchain/"
			mkdir -p "${HOME}/.intchain/"
			echo "Extracting '$FILE' to '${HOME}/.intchain/'"
			tar -C "${HOME}/.intchain/" -xzvf "$FILE" --strip-components 1 2>&1 |
			while read line; do
				x=$((x+1))
				echo -en "$x extracted\r"
			done
			echo "Extraction done !"
		else
			echo "$FILE does not exist. You have to download it."
		fi
	fi
	# restore back up
	echo -n "Restore your files (y/n)? "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		tar -xvf ${backup_file} -C "/"
	fi

else
	echo "You have to stop intchain first"
	exit
fi
