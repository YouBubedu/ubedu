#!/bin/bash

echo "------------欢迎使用Vagex-Forefix挂机一键配置脚本------------"
echo "----------------此脚本适用于CentOS6 64位系统-----------------"
echo "----------------------脚本作者：YouB-------------------------"
echo "---------------------联系QQ:3139406358-----------------------"
echo -e "--------------个人网站：\e[1;42mhttps://www.ubedu.site\e[0m---------------"
echo "---------------------脚本将会在3s后执行----------------------"
sleep 3s
#512M的小鸡增加1G的Swap分区
dd if=/dev/zero of=/var/swap bs=1024 count=1048576
mkswap /var/swap
chmod 0644 /var/swap
swapon /var/swap
echo '/var/swap   swap   swap   default 0 0' >> /etc/fstab

#安装cron
yum -y install vixie-cron
chkconfig crond on
service crond start

#安装VNC桌面环境
yum -y groupinstall "Gnome" "Desktop"
chkconfig NetworkManager off
service NetworkManager stop
yum -y install tigervnc
yum -y install tigervnc-server
vncserver
#查询包括关键字xterm所在的行，并替换为#xterm
sed -i '/xterm/s/^/#/' ~/.vnc/xstartup
sed -i '/twm/s/^/#/' ~/.vnc/xstartup
#在最后一行新增gnome-session &
sed -i '$a gnome-session &' ~/.vnc/xstartup
sed -i '$a VNCSERVERS="1:root"' /etc/sysconfig/vncservers
sed -i '$a VNCSERVERARGS[1]="-geometry 1024x768 -alwaysshared -depth 24"' /etc/sysconfig/vncservers
service vncserver restart
chmod +x ~/.vnc/xstartup
chkconfig vncserver on
service vncserver restart

#打开5901端口
iptables -I INPUT -p tcp --dport 5901 -j ACCEPT
service iptables reload

#安装火狐浏览器
yum -y install firefox
yum -y install fonts-chinese

#火狐优化
echo  "15 * * * * rm -rf /root/.vnc/*.log > /dev/null 2>&1"  >> /var/spool/cron/root
echo  "16 * * * * killall -9 firefox > /dev/null 2>&1"  >> /var/spool/cron/root
echo  "17 * * * * export DISPLAY=:1;firefox > /dev/null 2>&1"  >> /var/spool/cron/root
echo  "30 * * * * rm -rf /root/.vnc/*.log > /dev/null 2>&1"  >> /var/spool/cron/root
echo  "31 * * * * rm -rf /root/.vnc/*.log > /dev/null 2>&1"  >> /var/spool/cron/root
echo  "32 * * * * rm -rf /root/.vnc/*.log > /dev/null 2>&1"  >> /var/spool/cron/root
echo  "45 * * * * rm -rf /root/.vnc/*.log > /dev/null 2>&1"  >> /var/spool/cron/root
echo  "46 * * * * rm -rf /root/.vnc/*.log > /dev/null 2>&1"  >> /var/spool/cron/root
echo  "47 * * * * rm -rf /root/.vnc/*.log > /dev/null 2>&1"  >> /var/spool/cron/root

echo -e "------------------\e[1;41m系统将会在20s后自动重启\e[0m--------------------------"
echo "------------------待重启完成后启动VNC软件--------------------------"
echo -e "---------------------输入：\e[1;41m YourIP:1 \e[0m------------------------------"
echo "------------登陆VPS打开火狐浏览器安装Vagex登陆账号-----------------"
echo -e "---------参考：\e[1;42mhttps://www.ubedu.site/archives/360.html\e[0m------------"
echo "----------------------实现免流量挂机-------------------------------"
echo "------------------------祝挂机愉快---------------------------------"
sleep 20s
reboot
