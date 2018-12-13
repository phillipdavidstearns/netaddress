#!/bin/bash

#   netaddress.sh
#   a script to easily find usefull wireless network addresses
#   made for Mac OSX 10.13+
#   dependencies: networksetup, ifconfig, ipconfig

#Implemented:
#[i] IPv4 Local Address
#[r] IPv4 Router Address
#[s] IPv4 Subnet Mask
#[b] IPv4 Broadcast Address
#[p] Permanent MAC
#[c] Current MAC

#To Do:
#[I] IPv6 Local Address
#[R] IPv6 Router Address
#[S] IPv6 Subnet Mask
#[B] IPv6 Broadcast Address

#individually select
l=false
r=false
s=false
b=false
#L=false
#R=false
#S=false
#B=false
p=false
c=false

#select by protocol
IPv4=false
#IPv6=false
m=false

#show it all
all=true

function usage {
	echo "Usage: netaddress [-hlLrRsSbBpc46m] [interface]"
}

function help {
	echo -e "\r"
	usage
	echo -e "\r"
    echo "A simple tool to retrieve network addresses"
    echo -e "\r"
	echo "IPv4"
    echo -e "\t-4\t\tall IPv4 address info"
    echo -e "\t-l\t\tlocal IP"
	echo -e "\t-r\t\trouter IP"
	echo -e "\t-s\t\tsubnet mask"
	echo -e "\t-b\t\tbroadcast address"
#    echo "IPv6"
#    echo -e "\t-L\t\tlocal IP"
#    echo -e "\t-R\t\trouter IP"
#    echo -e "\t-S\t\tsubnet mask"
#    echo -e "\t-B\t\tbroadcast address"
	echo "MAC"
    echo -e "\t-m\t\tall MAC address info"
	echo -e "\t-c\t\tcurrent MAC"
	echo -e "\t-p\t\tpermanent MAC"
	echo -e "\r"
}

#arguments must be provided
if [ $# = 0 ];then
	usage
	exit 1
fi

#check for option flags
while getopts ":hlrsbLRSBpcm46" opt; do
    all=false
	case ${opt} in
		h)
			help
			exit 1
			;;
        l)
            l=true
            ;;
        r)
            r=true
            ;;
        s)
            s=true
            ;;
        b)
            b=true
            ;;
        4)
            IPv4=true
            ;;
#        L)
#            L  =true
#            ;;
#        R)
#            R=true
#            ;;
#        S)
#            S=true
#            ;;
#        B)
#            B=true
#            ;;
#        6)
#            IPv6=true
#            ;;
        p)
            p=true
            ;;
        c)
            c=true
            ;;
        m)
            m=true
            ;;
		\?)
			echo "[!] Invalid option."
			exit 0
			;;
	esac
done

shift $((OPTIND -1))

if [ $# = 1 ]; then
    if (ifconfig $1 > /dev/null 2>&1); then
        iface=$1
    else
        echo "[!] Invalid interface: $1"
        exit 1
    fi
else
    usage
    exit 1
fi

echo -e "\r"

# IPv4 Addresses

if [ "$all" = "true" -o "$IPv4" = "true" -o "$l" = "true" ]; then
    local_IPv4=$(ipconfig getifaddr $iface)
    echo "[+] Local IPv4 Address: $local_IPv4"
fi

if [ "$all" = "true" -o "$IPv4" = "true" -o "$r" = "true" ]; then
    router_IPv4=$(ipconfig getoption $iface router)
    echo "[+] Router IPv4 Address: $router_IPv4"
fi

if [ "$all" = "true" -o "$IPv4" = "true" -o "$s" = "true" ]; then
    mask_IPv4=$(ipconfig getoption $iface subnet_mask)
    echo "[+] Subnet Mask: $mask_IPv4"
fi

if [ "$all" = "true" -o "$IPv4" = "true" -o "$b" = "true" ]; then
    broadcast_IPv4=$(ifconfig $iface | sed -n 's/^.*broadcast //p')
    echo "[+] Broadcast IPv4 Address: $broadcast_IPv4"
fi

# IPv6 Addresses
#IPv6 Filter
#grep -oE '([[:xdigit:]]{0,4}:){7}[[:xdigit:]]{0,4}'

# MAC Addresses

if [ "$all" = "true" -o "$m" = "true" -o "$p" = "true" ]; then
    permanent_MAC=$(networksetup -getmacaddress $iface | grep -oE '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
    echo "[+] Hardware MAC Address: $permanent_MAC"
fi

if [ "$all" = "true" -o "$m" = "true" -o "$c" = "true" ]; then
    current_MAC=$(ifconfig $iface ether | grep -oE '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
    echo "[+] Current MAC Address: $current_MAC"
fi

echo -e "\r"

exit 0



