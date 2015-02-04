#!/bin/bash -f
source /opt/CPshrd-R77/tmp/.CPprofile.sh

#Including enviroment system variables
#Executing the script in the backup folder

cd /tmp/backup

#Deleting previous backups

rm *.mdsbk.tgz
rm mds_restore
rm gtar
rm gzip

#Creating the backup files, stopping processes, without saving logs and without asking
mds_backup -b -l -s

#Starting MDS services
mds_start

#Gzip all need files
now=$(date +"%m_%d_%Y")
tar -cvzf backup_SD_MDS_$now.tar.gz mds_restore gzip gtar *.mdsbk.tgz

#Moving the Gzip file to the ftp server
HOST=ip
USER=user
PASS=password

ftp -inv $HOST<<FINFTP
       user $USER $PASS
       put backup_SD_MDS_$now.tar.gz
       bye
FINFTP

#FIN
