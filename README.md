# netaddress.sh

A simple tool to easily fetch network addresses. Made for Mac OSX 10.13+.

Written by Phillip David Stearns 2018

## Installation
Clone or download and unzip into /usr/local/etc directory. From the commandline (requires git):

```
cd /usr/local/etc
git clone https://github.com/phillipdavidstearns/netaddress.git
```

Make the script executable:

```
chmod +x /usr/local/etc/netaddress/netaddress.sh
```

Create a symbolic link to your executable `$PATH`:

```
ln -s /usr/local/etc/netaddress/netaddress.sh /usr/local/bin/netaddress
```

You should no be able to execute the script with the `netaddress` command from the terminal.

## Usage
If you run `netaddress` without arguments, it'll print basic usage instructions to the terminal. Get the full help message by running `netaddress -h`.

```

Usage: netaddress [-hlLrRsSbBpc46m] [interface]


A simple tool to retrieve network addresses


IPv4
	-4		all IPv4 address info
	-l		local IP
	-r		router IP
	-s		subnet mask
	-b		broadcast address
MAC
	-m		all MAC address info
	-c		current MAC
	-p		permanent MAC
	
```

Basic usage is to run the command `netaddress [interface]` and get all the addresses for the specified interface. Right now, only IPv4 and MAC addresses are available. IPv6 will be added in the future.

### Examples:

```
user$ netaddress en0


[+] Local IPv4 Address: 192.X.X.X
[+] Router IPv4 Address: 192.X.X.254
[+] Subnet Mask: 255.X.X.X
[+] Broadcast IPv4 Address: 192.X.X.255
[+] Hardware MAC Address: XX:XX:XX:XX:XX:XX
[+] Current MAC Address: XX:XX:XX:XX:XX:XX


user$ netaddress -m en0


[+] Hardware MAC Address: XX:XX:XX:XX:XX:XX
[+] Current MAC Address: XX:XX:XX:XX:XX:XX


user$ netaddress -l en0


[+] Local IPv4 Address: 192.X.X.X


user$ netaddress -4 en0


[+] Local IPv4 Address: 192.X.X.X
[+] Router IPv4 Address: 192.X.X.254
[+] Subnet Mask: 255.X.X.X
[+] Broadcast IPv4 Address: 192.X.X.255


```