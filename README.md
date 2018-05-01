# MiWiFi-R1D-ShadowSocks
安装步骤


curl -o /tmp/ss.sh https://raw.githubusercontent.com/kiss4437/MiWiFi-R1D-ShadowSocks/master/miwifi-r1d-install.sh && sh /tmp/ss.sh



简单说一下gfwlistdnsmaq的更新

举例，ipset名称为gfw，地址127.0.0.1:1053，输出文件gfw_ipset.conf

gfwlist-dnsmasq.py -i gfwlist -d 127.0.0.1 -p 5353 -o gfw_ipset.conf

-l gfwlist.txt 使用本地gfwlist.txt(必须为原始base64压缩格式)

-o - 输出到STDOUT

-i - 不生成ipset规则
