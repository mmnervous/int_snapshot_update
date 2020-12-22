#!/bin/bash

# Script to resync INTCHAIN 4.0 Node written by @MMnervous
# Snapshot 17th December http://shaiiko.com/intchainData-20201217.tar.gz
# Snapshot 17th December https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz

FILE_NAME="mmch_825656_intchainData-20201222.tar.gz"
SNAPSHOT="http://shaiiko.com/${FILE_NAME}"
FILE="/tmp/${FILE_NAME}"
data_dir="${HOME}/.intchain"
backup_dir="${HOME}/backup"
backup_file="${backup_dir}/int_backup.tar"
intchain_pid="$(pidof intchain)"

# Color  Variables
RED='\e[31m'
GRN='\e[32m'
YLW='\e[33m'
BLU='\e[94m'
CLR='\e[0m'

echo -e "$BLU Last update Fri 22 Dec 2020 5:46 PM CET | Block height 825,656 $CLR"
if [[ -z "${intchain_pid}" ]]; then

	# Download
	echo -en "$YLW Start download (y/n)?  $CLR"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		rm -rf /tmp/*intchain*
		echo "Downloading blockchain snapshot from $SNAPSHOT"
		wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
	fi

	# Backup
	echo -en "$YLW Backup your files (y/n)?  $CLR"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		mkdir -p ~/backup
		rm -rf $backup_file
		tar -cvf "${backup_file}" $(find ${data_dir} -name "UTC*" -or -name "nodekey" -or -name "priv_validator.json")
	fi

	# Exctraction
	echo -en "$YLW Start extraction (y/n)?  $CLR"
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
			echo -e "$GRN Extraction done ! $CLR"
		else
			echo -e "$FILE $RED does not exist. You have to download it. > EXIT $CLR"
			exit
		fi
	fi

	# restore back up
	echo -en "$YLW Restore your files (y/n)?  $CLR"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		tar -xvf ${backup_file} -C "/"
	fi
	echo -e "$GRN Done ! End of script $CLR"
else
	echo -e "$RED You have to stop intchain first > EXIT $CLR"
	exit
fi
