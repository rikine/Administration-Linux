#!/bin/bash

#1
dnf groupinstall "Development Tools"

#2
tar -zxvf ~/for_installation
# Команды tar
# -z : Распакует полученный архив с помощью команды GZIP.
# -x : Извлечение файлов на диск из архива.
# -v : Показывает сам процесс распаковки файлов при извлечении файлов.
# -f my_backup.tgz : Read the archive from the specified file called my_backup.tgz.

cd bastet-0.43
make

nano Makefile
# install: all
#       mv bastet /usr/bin

make install

#3
dnf list installed > task3.log

#4
dnf repoquery --deplist gcc > task4_1.log
dnf repoquery --whatrequires libgcc > task4_2.log

#5
dnf install localrepo
mkdir ~/localrepo
cp ~/for_installation/checkinstall-1.6.2-3.el6.1.x86_64.rpm ~/localrepo
nano /etc/yum.repos.d/localrepo.repo

#[localrepo]
#name=localrepo
#mirrorlist=file:///root/localrepo/
#enabled=1
#gpgcheck=0

#6
dnf repolist all > ~/task6.log

#7
for line in $(ls -1 /etc/yum.repos.d/)
do
        cat /etc/yum.repos.d/$line | sed "s/enabled=1/enabled=0/" > /etc/yum.repos.d/$line
done
