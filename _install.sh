#!/bin/bash
echo "設定時區為Asia/Taipei"
timedatectl set-timezone 'Asia/Taipei'
RED='\033[0;31m'
NC='\033[0m'
now=$(date +%Y-%m-%d-%H:%M)
echo -e "現在時間${RED}${now}${NC}"
echo -e "安裝將會在${RED}5秒${NC}後開始"
sleep 5
echo "更新"
yum update -y
echo "安裝NTP套件，調整時區用"
yum install -y ntp
echo "重啟ntp服務"
service ntpd restart
echo "安裝 net-tools"
yum install -y net-tools
echo "安裝 wget"
yum install -y wget
echo "安裝 git"
yum install -y git
echo "安裝 zip unzip"
yum install -y zip unzip
echo "設定repo，讓yum抓的到PHP7的來源"
wget -q http://rpms.remirepo.net/enterprise/remi-release-7.rpm
wget -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh epel-release-latest-7.noarch.rpm
rpm -Uvh remi-release-7.rpm
echo "安裝 yum-utils"
yum install -y yum-utils
echo "安裝PHP7.1"
yum-config-manager --enable remi-php71
yum install -y php
echo "開始安裝PHP7會用到的套件"
echo "安裝php xml"
yum install -y php-xml
echo "安裝php pdo(操作資料庫)"
yum install -y php-pdo
echo "安裝php bcmath(計算的lib)"
yum install -y php-bcmath
echo "安裝php mbstring(寫入log)"
yum --enablerepo=remi install -y php-mbstring
echo "清除戰存檔&跟沒用到的pkg"
yum autoremove -y
yum clean all
rm -rf '/var/cache/yum'
rm -rf epel-release-latest-7.noarch.rpm
rm -rf remi-release-7.rpm