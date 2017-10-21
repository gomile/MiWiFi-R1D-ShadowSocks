#!/bin/sh
rm -f $0
mount -o remount rw /

clear
echo "#############################################################"
echo "# Install Shadowsocks for Miwifi"
echo "#############################################################"


#config setting and save settings.
echo "#############################################################"
echo "#"
echo "# Please input your shadowsocks configuration"
echo "#"
echo "#############################################################"
echo ""
echo "请输入服务器IP:"
read serverip
echo "请输入服务器端口:"
read serverport
echo "请输入密码"
read shadowsockspwd
echo "请输入加密方式"
read method

# Config shadowsocks
if [ -f "/etc/shadowsocks.json" ]; then
    cp -f /etc/shadowsocks.json /etc/shadowsocks.json.bak
	rm -f /etc/shadowsocks.json
fi
cat > /etc/shadowsocks.json<<-EOF
{
  "server": "${serverip}",
  "server_port": ${serverport},
  "local_port": 1081,
  "password": "${shadowsockspwd}",
  "timeout": 60,
  "method": "${method}"
}
EOF


# Config shadowsocks init script
if [ -f "/etc/init.d/shadowsocks" ]; then
    cp -f /etc/init.d/shadowsocks /etc/init.d/shadowsocks.bak
	rm -f /etc/init.d/shadowsocks
fi
curl -o /etc/init.d/shadowsocks https://raw.githubusercontent.com/kiss4437/MiWiFi-R1D-ShadowSocks/master/shadowsocks
chmod +x /etc/init.d/shadowsocks
ln -s /etc/init.d/shadowsocks /bin/shadowsocks

#config dnsmasq
if [ ! -d "/etc/dnsmasq.d" ]; then
  mkdir -p /etc/dnsmasq.d
fi
rm -rf /etc/dnsmasq.d/*
curl -o /etc/dnsmasq.d/gfw_ipset.conf  http://webbackup-10046856.cossh.myqcloud.com/gfwlist/gfw_ipset.conf


#restart all service
/etc/init.d/dnsmasq restart
/etc/init.d/shadowsocks start
/etc/init.d/shadowsocks enable

#install successfully
ps | grep ss-redir | grep -v grep
if [ $? -ne 0 ]
then
echo ""
echo "Shadowsocks安装失败....！"
echo ""
else
echo ""
echo "Shadowsocks安装成功！"
echo ""
fi
exit 0
