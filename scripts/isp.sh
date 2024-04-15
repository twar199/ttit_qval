#!/bin/bash

#Измение имени хоста
sudo hostnamectl set-hostname ISP
hostname

# Создание dummy0 интерфейса с адресом 2.2.2.2/32
ip link add dummy0 type dummy
ip addr add 2.2.2.2/32 dev dummy0
ip link set dummy0 up

# Создание пользователей
useradd -m -p $(openssl passwd -1 P@ssw0rd) Admin
useradd -m -p $(openssl passwd -1 P@ssw0rd) Branch_admin
useradd -m -p $(openssl passwd -1 P@ssw0rd) Network_admin

# Установка программы FRR
sudo apt-get update -y
sudo apt-get install frr -y

# Изменение значений в конфигурационном файле
sed -i 's/ospfd=no/ospfd=yes/g' /etc/frr/daemons
sed -i 's/ospf6d=no/ospf6d=yes/g' /etc/frr/daemons
sed -i 's/zebra=no/zebra=yes/g' /etc/frr/daemons

# Перезапуск сервиса FRR
sudo systemctl restart frr
sudo systemctl start frr
sudo systemctl enable frr

# Зайти в vtysh и выполнить необходимые команды
vtysh -c 'conf t' -c 'router ospf' -c 'ospf router-id 2.2.2.2' -c 'network 172.16.0.0/30 area 2' -c 'network 10.0.10.0/30 area 0' -c 'network 10.0.20.0/30 area 0' -c 'exit' -c 'exit' -c 'write'

# Изменение значения в файле /etc/sysctl.conf и применение изменений
sed -i 's/#net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sysctl -p

# Установка iperf3 и isc-dhcp-server
sudo apt install iperf3 isc-dhcp-server -y

# Создание каталога для бэкапа 
mkdir -p /mnt/backup

# Создание бэкапов 
tar -czf /mnt/backup/home_backup.tar.gz /home 
tar -czf /mnt/backup/etc_backup.tar.gz /etc 
tar -czf /mnt/backup/root_backup.tar.gz /root 
tar -czf /mnt/backup/boot_backup.tar.gz /boot 
tar -czf /mnt/backup/opt_backup.tar.gz /opt
ls -lh /mnt/backup
echo "Done. Backup's on the /mnt/backup directory"


