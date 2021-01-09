#!/bin/bash

# Script to resync INTCHAIN 4.0 Node written by @MMnervous
# Snapshot 17th December http://shaiiko.com/intchainData-20201217.tar.gz
# Snapshot 17th December https://blockdata-1258895559.cos.ap-shanghai.myqcloud.com/intchainData-20201217.tar.gz

FILE_NAME="intchainData-20210109.tar.gz"
SNAPSHOT="http://shaiiko.com/${FILE_NAME}"
FILE="/tmp/${FILE_NAME}"
DATA_DIR="${HOME}/.intchain"

# Color  Variables
RED='\e[31m'
GRN='\e[32m'
YLW='\e[33m'
BLU='\e[94m'
CLR='\e[0m'

if [[ "$(pidof intchain)" ]]; then # checking if intchain is running
	echo -e "${RED}You have to stop intchain first ${CLR}"
	exit
else
	echo -e "${BLU}Last update Sat 09 Jan 2021 11:53 AM CET | Block height 1,294,167 ${CLR}"

	read -p "Start download (y/n)? " ANSWER
	if [[ "${ANSWER}" != "${ANSWER#[Yy]}" ]] ;then
		rm -rf /tmp/*intchain*
		wget -q --show-progress "$SNAPSHOT" -P "/tmp/"
	fi

	read -p "Backup your files (y/n)? " ANSWER
	if [[ "${ANSWER}" != "${ANSWER#[Yy]}" ]] ;then
		TMP_DIR=$(mktemp -d -t int_backup-XXXX)
		tar -cvf ${TMP_DIR}/backup.tar $(find ${DATA_DIR} -name "UTC*" -or -name "nodekey" -or -name "priv_validator.json")
		BACKUP=true
	fi

	read -p "Start extraction (y/n)? " ANSWER
	if [[ "${ANSWER}" != "${ANSWER#[Yy]}" ]] ;then
		if [[ -f "${FILE}" ]]; then
			echo "${FILE} exists."
			rm -rf "${HOME}/.intchain/"
			mkdir -p "${HOME}/.intchain/"
			echo "Extracting '$FILE' to '${HOME}/.intchain/'"
			tar -C "${HOME}/.intchain/" -xzvf "$FILE" --strip-components 1 2>&1 |
			while read line; do # show how much files are extracted
				x=$((x+1))
				echo -en "${x} extracted\r"
			done
			echo -e "${GRN}Extraction done ! ${CLR}"
		else
			echo -e "${FILE} ${RED} does not exist. You have to download it. > EXIT ${CLR}"
			exit
		fi
	fi

	if [[ "${BACKUP}" ]] ;then
		read -p "Restore your files (y/n)? " ANSWER
		if [[ "${ANSWER}" != "${ANSWER#[Yy]}" ]] ;then
			tar -xvf ${TMP_DIR}/backup.tar -C "/"
		fi
	fi
	echo -e "${GRN}Done ! End of script ${CLR}"
fi
