#!/bin/sh
echo ''
echo '***************************************'
echo 'CDLM.space backup start at ' $(date +'%T') ' the ' $(date +'%d/%m/%Y')

#cp /etc/apache2/sites-available/cdlm.space.conf $1/apache2/
mysqldump -u antoinedb -p'zeibkcnc' cdlmdb > $1/mysql/cdlmdb.sql

echo '------'
echo 'Database backup'
cd $1/mysql/
git commit -am "CDLM DATABASE SAVE AT $(date +'%H:%M') the $(date +'%d/%m/%Y')"
git push origin master

echo '------'
echo 'Pictures backup'
rsync -avz /var/www/CDLM/public/upload/pictures/ antoine@antoinesmagghe.com:~/cdlmsave/public/upload/pictures/ --delete-before 2>> ~/.log/rsync_fail.log

echo ''
echo 'Job is done at ' $(date +'%T') ' the ' $(date +'%d/%m/%Y')
echo '***************************************'