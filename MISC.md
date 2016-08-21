#Requirements

## Hardware:

- 256(Mb) RAM
- 3 Network Interface Controlers (Optional but recommended)
- 768(Mb) Recommended for optional Developer Package installation

## Software
NOTE: These are some recommended Operating Systems to us Proxy Broker with

- Ubuntu Desktop
- Kali Linux
- Backbox
- ParrotOS

#Folders

- ca

    Certificate authority files
- certs

    MiTM certificates that are created 'on-the-go'
- db

    Where all database files are stored
- broker

    Empty directory
- src

    Where Proxy Broker operates from
- scripts

    Scripts used to configure the Proxy Broker enviroment

#Usage (PPTP Shown Only)
- Connect your victim to the PPTP server
- SetUp the interface so that PPP0 is being middled & eth0 is the outbound
- UnComment or add any protocols/ports you'd like & apply them
- Create a debug rule for your enviroment by
  1. Create the rule
  2. Re-name the rule
  3. Set rule type to debug
  4. Save rule
- Use the intercept function to begin listening
