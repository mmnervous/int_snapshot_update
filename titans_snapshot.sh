# Blockchain snapshot
# Snapshot 17th December http://shaiiko.com/intchainData-20201217.tar.gz
# Snapshot 17th December https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz
# tar -xvf ${backup_file} -C "/"

# if [[ -n "${intchain_pid}" ]]; then
#     echo "INTCHAIN is running > exit"
#     exit
# fi

SNAPSHOT="http://shaiiko.com/mmch_825656_intchainData-20201222.tar.gz"
FILE=/tmp/mmch_825656_intchainData-20201222.tar.gz
data_dir="${HOME}/.intchain"
backup_dir="${HOME}/backup"
backup_file="${backup_dir}/int_backup.tar"
intchain_pid="$(pidof intchain)"

echo -e "\e[94mLast update Fri 22 Dec 2020 3:45 PM CET | Block height 825,656\e[0m"
if [[ -z "${intchain_pid}" ]]; then

	# Download
	echo -en "\e[33mStart download (y/n)? \e[0m"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		rm -rf /tmp/*intchain*
		echo "Downloading blockchain snapshot from $SNAPSHOT"
		wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
	fi

	# Backup
	echo -en "\e[33mBackup your files (y/n)? \e[0m"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		mkdir -p ~/backup
		rm -rf $backup_file
		tar -cvf "${backup_file}" $(find ${data_dir} -name "UTC*" -or -name "nodekey" -or -name "priv_validator.json")
	fi

	# Exctraction
	echo -en "\e[33mStart extraction (y/n)? \e[0m"
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
			echo -e "\e[32mExtraction done !\e[0m"
		else
			echo -e "$FILE \e[31mdoes not exist. You have to download it. > EXIT\e[0m"
			exit
		fi
	fi

	# restore back up
	echo -en "\e[33mRestore your files (y/n)? \e[0m"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		tar -xvf ${backup_file} -C "/"
	fi
	echo -e "\e[32mDone ! End of script\e[0m"
else
	echo -e "\e[31mYou have to stop intchain first > EXIT\e[0m"
	exit
fi
