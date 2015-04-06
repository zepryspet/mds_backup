#!/bin/bash
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

#TARing all need files
now=$(date +"%d-%b-%Y")
tar -cvf backup_MDS_$now.tar mds_restore gzip gtar *.mdsbk.tgz

#Moving the Gzip file to the ftp server
HOST=ip
USER=user
PASS=password

ftp -inv $HOST<<FINFTP
       user $USER $PASS
       put backup_MDS_$now.tar
       bye
FINFTP

#Remove the TARed file
rm backup_MDS_$now.tar

#Starting MDS services, patched as stated by sk101903
mds_start -s

#FIN
