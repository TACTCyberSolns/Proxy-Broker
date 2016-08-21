#!/bin/bash

export UPDATE_DIR=${HOME}/.broker/update
export UPDATE_LOG=${UPDATE_DIR}/update.log

function print_header {
	echo "______                     ______           _             "
	echo "| ___ \                    | ___ \         | |            "
	echo "| |_/ / __ _____  ___   _  | |_/ /_ __ ___ | | _____ _ __ "
	echo "|  __/ '__/ _ \ \/ / | | | | ___ \ '__/ _ \| |/ / _ \ '__|"
	echo "| |  | | | (_) >  <| |_| | | |_/ / | | (_) |   <  __/ |   "
	echo "\_|  |_|  \___/_/\_\\__, | \____/|_|  \___/|_|\_\___|_|   "
	echo "                     __/ |                                "
	echo "                    |___/                                 "
	echo " _   _           _       _            "                            
	echo "| | | |         | |     | |           "                  
	echo "| | | |_ __   __| | __ _| |_ ___ _ __ "             
	echo "| | | | '_ \ / _` |/ _` | __/ _ \ '__|"
	echo "| |_| | |_) | (_| | (_| | ||  __/ |   "
	echo " \___/| .__/ \__,_|\__,_|\__\___|_|   "
    echo "      | |                             "
	echo "      |_|                             "
}

function pbu0 {
	[[ ! -d ${UPDATE_DIR} ]] && mkdir -p ${UPDATE_DIR}
	print_header
	echo "+--------------------------------------------------------+"
	echo "| Before attempting an install, please ensure that you   |"
	echo "| have an active network connection & that it is         |"
	echo "| reachable from the Virtual Machine                     |"
	echo "+--------------------------------------------------------+"
	echo "| Re-Run this script to continue w/ your update!         |"
	echo "+--------------------------------------------------------+"
	echo "pbu1" > ${UPDATE_DIR}/.next_phase
	exit 0
}

function pbu1 {
	print_header
	echo "+--------------------------------------------------------+"
	echo "| [!] Beginning Proxy Broker installation!               |"
	echo "| [I] Updating apt package list...                       |"
	sudo apt-get update |tee ${UPDATE_LOG}
	echo "|                                                        |"
	echo "| [I] Updating installed packages to latest verstion...  |"
	sudo apt-get upgrade -y |tee -a ${UPDATE_LOG}
	echo "| [!] Installing Proxy Broker Dependencies!              |"
	if [ ! -f /usr/lib/netfilter_conntrack.so.1 ]; then
		sudo ln -s /usr/lib/libnetfilter_conntrack.so /usr/lib/libnetfilter_conntrack.so.1
	fi
	sudo apt-get -y install python-pip python-m2crypto python-qt4 pyro-gui python-netfilter python-pyasn1 |tee -a ${UPDATE_LOG}
	sudo apt-get -y install python-paramiko python-twisted-web python-qt4-sql libqt4-sql-sqlite sqlite3 |tee -a ${UPDATE_LOG}
	sudo easy_install pynetfilter_conntrack
	echo "|                                                        |"
	echo "| Enter the directory you Proxy Broker installed on...   |"
	read -p "(default: ${HOME}/broker)" pbdir
	if [ "$pbdir" == ""]; then
		pbdir="${HOME}/broker";
	fi
	echo ${pbdir} > ${UPDATE_DIR}/installdir
	echo "| [!]Retrieving current Proxy Broker source from GitHub! |"
	/usr/bin/hg clone https://github.com/TACTCyberSolns/Proxy-Broker ${pbdir}/current
	echo "+--------------------------------------------------------+"
	echo "pbu2" > ${UPDATE_DIR}/.next_phase
	pbu2
}

function pbu2 {
	print_header
	echo "+--------------------------------------------------------+"
	echo "| [!] Proxy Broker installation completed successfully!  |"
}
