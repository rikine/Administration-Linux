#!/bin/sh

rm -rf /mnt/newdisk
rm -rf ~/newdisk_slink
rm -rf /mnt/share

#1
fdisk /dev/sdb
# n
# p
# 1
# enter (from start)
# +300M
# w
# shutdown -r now

#2
sudo blkid /dev/sdb1 | cut -d '"' -f 2 > ~/UUID_Part_1

#3
mke2fs -t ext4 -b 4096 /dev/sdb1
fsck -N /dev/sdb1

#4
dumpe2fs -h /dev/sdb1

#5
tune2fs -i 2m -C 2 /dev/sdb1

#6
#mkdir /mnt/newdisk
#sudo mount -t ext4 /dev/sdb1 /mnt/newdisk

#7
ln -s /mnt/newdisk ~/newdisk_slink

#8
mkdir ~/newdisk_slink/any

#9
# sudo nano /etc/fstab /dev/sdb1 /mnt/newdisk ext4 noexec,noatime 0 0

#10
umount /dev/sdb1
fdisk /dev/sdb
# d
# 1
# n
# p
# 1
# enter
# +350M
# N (don't del)
# w

# reboot
resize2fs /dev/sdb1
df -h

#11
fdisk /dev/sdb
# n
# p
# 2
# enter
# +12M
# w

#12
umount /dev/sdb1
mke2fs -O journal_dev /dev/sdb2
mke2fs -t ext4 -J device=/dev/sdb2 /dev/sdb1

#13
fdisk /dev/sdb
# n
# p
# 3
# enter
# +100M
# n
# p
# 4
# enter
# +100M
# w

#14
pvcreate /dev/sdb3 /dev/sdb4
vgcreate vg1 /dev/sdb3 /dev/sdb4
lvcreate -L 192 -n logical_vol1 vg1
mkfs.ext4 /dev/vg1/logical_vol1
mkdir /mnt/supernewdisk
mount /dev/vg1/logical_vol1 /mnt/supernewdisk

#15
mkdir /mnt/share
mount.cifs //172.20.10.4/temp /mnt/share -o credentials=/etc/password_smb

# 16
# /etc/fstab //172.20.10.4/temp /mnt/share cifs credentials=/etc/password_smb 0 0