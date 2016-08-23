setProxyType()
{
    kdb setmeta "${MountPoint}/${prefType}/network/proxy/type" type integer
    kdb set "${MountPoint}/${prefType}/network/proxy/type" "$1"
}

proxySetup()
{
    echo "Setting up HTTP Proxy"
    readPrefType
    echo -e "Proxy Type\n0) No Proxy\n1) Manual Setup\n2) PAC\n4) Auto-detect\n5) System Settings\n"
    read -s -n 1 sel
    case "$sel" in
	0)
	    setProxyType 0
	    return
	    ;;
	1)
	    setProxyType 1
	    ;;
	2)
	    setProxyType 2
	    return
	    ;;
	4)
	    setProxyType 4
	    return
	    ;;
	5)
	    setProxyType 5
	    return
	    ;;
	*)
	    echo "Error, invalid selection"
	    return
	    ;;
    esac
    read -p "Host/IP: " myHost
    read -p "Port: " myPort
    echo -e "Setting $prefString HTTP Proxy to $myHost:$myPort"
    kdb setmeta "${MountPoint}/${prefType}/network/proxy/type" type integer
    kdb set "${MountPoint}/${prefType}/network/proxy/type" 1
    kdb setmeta "${MountPoint}/${prefType}/network/proxy/http" type string
    kdb set "${MountPoint}/${prefType}/network/proxy/http" "$myHost"
    kdb setmeta "${MountPoint}/${prefType}/network/proxy/http_port" type integer
    kdb set "${MountPoint}/${prefType}/network/proxy/http_port" "$myPort"
}

proxySetup
