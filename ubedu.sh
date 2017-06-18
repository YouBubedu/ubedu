#!/bin/bash

echo -e "------------------欢迎使用ubedu综合配置脚本------------------"
echo -e "----------------此脚本适用于CentOS6 64位系统-----------------"
echo -e "----------------------脚本作者：YouB-------------------------"
echo -e "---------------------联系QQ:3139406358-----------------------"
echo -e "--------------个人网站：\e[1;42mhttps://www.ubedu.site\e[0m---------------"
echo -e "---------------------脚本将会在3s后执行----------------------"
sleep 3s

#系统更新
echo -e "Do you want to update?[y/n]:\c"
read updateor
if [ "$updateor" = "y" ]
then
yum update -y
fi

#修改root登陆端口
lport=`netstat -antp | grep sshd| awk -F ":" '{print $4}' | awk '{if($0 !~/^$/)print $0}'`
echo -e "Your current port number is:$lport"
echo -e "Do you want to change?[y/n]:\c"
read sshportor
if [ "$sshportor" != "y" ]
then
	exit
else
	echo -e "Please Input Port (0~65535):\c"
	read nport
	if [ "$nport" -gt "0" ] && [ "$nport" -lt "65525" ] && [ "$nport" -ne "$lport" ]
		then 
			echo -e "Your Root user login port number will be changed to : $nport"
			sed -i "/Port /s/^.*$/Port $nport/" /etc/ssh/sshd_config
			iptables -D INPUT -p tcp --dport $lport -j ACCEPT
			iptables -I INPUT -p tcp --dport $nport -j ACCEPT
			service iptables save
			service sshd restart
			service iptables reload
		else
			echo -e "\e[1;41mPlease Input another port number!!!\e[0m"
			exit
	fi
fi

#系统禁ping
echo -e "Do you want to ban ping?[y/n]:\c"
read banpingor
if [ "$banpingor" = "y" ]
then
sed -i '$a\net.ipv4.icmp_echo_ignore_all=1' /etc/sysctl.conf
sysctl -p
else
sed -i '$a\net.ipv4.icmp_echo_ignore_all=0' /etc/sysctl.conf
sysctl -p
fi

#增加Swap内存
echo -e "Do you want to add Swap?[y/n]:\c"
read addswapor
if [ "$addswapor" = "y" ]
then
echo -e "Please Input the Swap Size (unit:Gb default:1):\c"
read swapsize
dd if=/dev/zero of=/var/swap bs=1024 count=$[$swapsize * 1024000]
mkswap /var/swap
chmod 0644 /var/swap
swapon /var/swap
echo '/var/swap   swap   swap   default 0 0' >> /etc/fstab
fi
free -m
sleep 3s
echo -e "------------------欢迎使用ubedu综合配置脚本------------------"
echo -e "----------------此脚本适用于CentOS6 64位系统-----------------"
echo -e "----------------------脚本作者：YouB-------------------------"
echo -e "---------------------联系QQ:3139406358-----------------------"
echo -e "--------------个人网站：\e[1;42mhttps://www.ubedu.site\e[0m---------------"
