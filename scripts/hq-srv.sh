#!/bin/bash

# Изменение имени хоста
sudo hostnamectl set-hostname HQ-SRV
hostname

# Создание пользователей
useradd -m -p $(openssl passwd -1 P@ssw0rd) Admin
useradd -m -p $(openssl passwd -1 P@ssw0rd) "Branch_admin"
useradd -m -p $(openssl passwd -1 P@ssw0rd) "Network_admin"

# Установка iptables и iptables-persistent
sudo apt-get update -y
sudo apt-get install iptables iptables-persistent ssh -y
sudo systemctl start ssh
sudo systemctl enable ssh

# Устанавливаем новый SSH порт
sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Разрешаем доступ к SSH по новому порту только с указанных подсетей
sudo iptables -A INPUT -p tcp --dport 2222 -s 192.168.10.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2222 -s 192.168.20.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2222 -s 10.0.10.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2222 -s 10.0.20.0/24 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2222 -s 172.16.0.2 -j DROP

# Сохраняем настройки iptables
sudo iptables-save > /etc/iptables/rules.v4
