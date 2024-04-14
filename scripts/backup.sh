#!/bin/bash

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