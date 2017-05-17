# ubedu
some auto run
<h1>一.locCheckin</h1></br>
1.VPS安装如下内容<br>
yum -y install python-pip<br>
pip install requests<br>
pip install beautifulsoup4<br>
#pip install lxml<br>


2.下载<br>
wget  -O  /tmp/locCheckin.py https://raw.githubusercontent.com/YouBubedu/ubedu/master/locCheckin.py<br>
vi locCheckin.py 修改用户名和密码<br>
利用crontab 加入定时任务中<br>
yum install cron<br>
crontab -e<br>
0 */8 * * * python /tmp/locCheckin.py<br>


<h3>fork from challengeYY</h3></br>


<h1>二.Vagex-Firefox</h1>
wget -N --no-check-certificate https://raw.githubusercontent.com/YouBubedu/ubedu/master/Vagex-Firefox.sh && chmod +x Vagex-Firefox.sh && bash Vagex-Firefox.sh
