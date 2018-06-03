#!/bin/sh /etc/rc.common
# Copyright (C) 2006-2011 OpenWrt.org


while true
do
    nslookup www.tumblr.com
    if [ $? -ne 0 ];then
        echo "网络连接失败，正在重启服务!"
		shadowsocks restart
        sleep 60
    else
		echo "程序正常运行"
		sleep 60
    fi
done
