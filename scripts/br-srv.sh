#!/bin/bash

#Измение имени хоста
sudo hostnamectl set-hostname BR-SRV
hostname

# Создание пользователей
useradd -m -p $(openssl passwd -1 P@ssw0rd) Admin
useradd -m -p $(openssl passwd -1 P@ssw0rd) Branch_admin
useradd -m -p $(openssl passwd -1 P@ssw0rd) Network_admin
