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
}

function pbi0 {
	[[ ! -d ${UPDATE_DIR} ]] && mkdir -p ${UPDATE_DIR}
	print_header
	echo "+--------------------------------------------------------+"
	echo "| Before attempting an install, please ensure that you   |"
	echo "| have an active network connection & that it is         |"
	echo "| reachable from the Virtual Machine                     |"
	echo "+--------------------------------------------------------+"
	echo "| Re-Run this script to continue w/ your update!         |"
	echo "+--------------------------------------------------------+"
	echo "pbi1" > ${UPDATE_DIR}/.ni
	exit 0
}

function pbi1 {
	print_header
	echo "+--------------------------------------------------------+"
	echo "| [!] Beginning Proxy Broker installation!               |"
	echo "| [I] Updating apt package list...                       |"
	sudo apt-get update |tee ${UPDATE_LOG}
	echo "+--------------------------------------------------------+"
	echo "| [I] Updating installed packages to latest verstion...  |"
	sudo apt-get upgrade -y |tee -a ${UPDATE_LOG}
	echo "| [!] Installing Proxy Broker Dependencies!              |"
	if [ ! -f /usr/lib/netfilter_conntrack.so.1 ]; then
		sudo ln -s /usr/lib/libnetfilter_conntrack.so /usr/lib/libnetfilter_conntrack.so.1
	fi
	sudo apt-get -y install python-pip | tee -a ${UPDATE_LOG}
	sudo apt-get -y install python-m2crypto |tee -a ${UPDATE_LOG}
	sudo apt-get -y install python-qt4 |tee -a ${UPDATE_LOG}
	sudo apt-get -y install pyro-gui |tee -a ${UPDATE_LOG}
	sudo apt-get -y install python-netfilter |tee -a ${UPDATE_LOG}
	sudo apt-get -y install python-pyasn1 |tee -a ${UPDATE_LOG}
	sudo apt-get -y install python-paramiko  |tee -a ${UPDATE_LOG}
	sudo apt-get -y install python-twisted-web  |tee -a ${UPDATE_LOG}
	sudo apt-get -y install python-qt4-sql  |tee -a ${UPDATE_LOG}
	sudo apt-get -y install libqt4-sql-sqlite sqlite3 |tee -a ${UPDATE_LOG}
	sudo easy_install pynetfilter_conntrack
	echo "+--------------------------------------------------------+"
	echo "| Enter the directory you Proxy Broker installed on...   |"
	read -p "(default: ${HOME}/broker)" pbdir
	if [ "$pbdir" == ""]; then
		pbdir="${HOME}/broker";
	fi
	echo ${pbdir} > ${UPDATE_DIR}/installdir
	echo "| [!]Retrieving current Proxy Broker source from GitHub! |"
	/usr/bin/hg clone https://github.com/TACTCyberSolns/Proxy-Broker ${pbdir}/current
	echo "+--------------------------------------------------------+"
	echo "pbi2" > ${UPDATE_DIR}/.ni
	pbu2
}

function pbi2 {
	print_header
	echo "+--------------------------------------------------------+"
	echo "| [!] Proxy Broker installation completed successfully!  |"
	echo "+--------------------------------------------------------+"
	echo "| [I] Usage:                                             |"
	echo "|       ${pbdir}/current/src                             |"
	echo "|       sudo pyhton ./proxy-broker.py                    |"
	echo "+--------------------------------------------------------+"
	read -n1 -p "| Press any key to continue...                           |"
	echo "pbu" > ${UPDATE_DIR}/.ni
	exit 0
}

function pbu {
	print_header
	echo "+--------------------------------------------------------+"
	echo "| [!] Starting update process                            |"
	if [ ! -d ${UPDATE_DIR} ]; then
		ehco "| [!] Update directory not found! Terminating update... |"
		exit 1
	fi
	if [ ! -f ${UPDATE_DIR}/installdir ]; then
		ehco "| [!] Installation directory not fount, Terminating...  |"
		exit 1
	fi
	export pbdir= cat ${UPDATE_DIR}/installdir
	if [ ! -d ${pbdir} ]; then
		echo "| [!] Installation directory does not exist, Haulting!  |"
		exit 1
	fi
	echo "| [!] Moving current install to archive!                 |"
	if [[ -d ${pbdir}/archive ]]; then
		rm -rf ${pbdir}/archive/*
	else
		mkdir ${pbdir}/archive
	fi
	if [[ -d ${pbdir}/current ]]; then
		cp -R {$pbdir}/current/* ${pbdir}/archive/
	fi
	rm -rf ${pbdir}/current
	echo "| [!] Reterieving current Proxy Broker source from GitHub! |"
	/usr/bin/hg clone http://github.com/TACTCyberSolns/Proxy-Broker ${pbdir}/current
	echo "pbu" > ${UPDATE_DIR}/.ni
	exit 0
}

if [[ -f ${UPDATE_DIR]/.ni ]]; then
	case `cat ${UPDATE_DIR/.ni}` in
		pbi0)
			pbi0
		;;
		pbi1)
			pbi1
		;;
		pbi2)
			pbi2
		;;
		pbu)
			update
		;;
		*)
			echo "| [!] Unknown update status, attempting...                 |"
			pbu
		;;
	esac
else
	pbi0
fi
