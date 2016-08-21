# Synopsis
'Proxy Broker' is an extensive UDP/TCP proxy designed to "man-in-the-middle" traffic for testing purposes, while allowing you to modify non-standard protocols "on the go".

# Proxy Broker Dependencies
- python-pip
- python-m2crypto
- python-qt4
- pyro-gui
- python-netfilter
- python-pyasn1
- python-paramiko
- python-twisted-web
- python-qt4-sql
- libqtr-sql-sqlite
- sqlite3
- build-essential
- libnetfilter-conntrack-dev
- libnetfilter-conntrack3

# Installation
```
tact@cybersolns:~$ cd proxy-broker
tact@cybersolns:~$ sudo ./pbinstall.sh
```

# Starting Proxy Broker Services
```
tact@cybersolns:~$ cd src
tact@cybersolns:~$ sudo python ./pbservice.py
```

# Contributors
1. Sean Hill [@AzzusssUBT](http://twitter.com/AzzusssUBT)
2. Craig Kupinsky [@craigkupinsky](http://twitter.com/craigkupinsky)
