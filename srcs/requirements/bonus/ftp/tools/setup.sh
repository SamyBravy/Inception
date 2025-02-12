#!/bin/bash

set -e

if id -u "$FTP_USER" >/dev/null 2>&1; then
	echo "Ready to go!"
else
	useradd -m $FTP_USER

	echo  $FTP_USER:$FTP_PASS | /usr/sbin/chpasswd

	chmod -R 755 /var/www

	chown -R $FTP_USER:$FTP_USER /var/www

	echo "${FTP_USER}" >> /etc/vsftpd.userlist

	mkdir -p /var/run/vsftpd/empty
fi

vsftpd /etc/vsftpd.conf
