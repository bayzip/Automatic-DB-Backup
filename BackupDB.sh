#!/bin/bash

echo "Masukkan Username Database: "
read UserDB
echo "Masukkan Password Database: "
read PassDB
echo "Masukkan Nama Database: "
read NameDB
echo "Masukkan Output file Database: "
read PathDB

//Memberi nama Database
namafiledb = $PathDB-$(date +%Y%m%d).sql

//Menghapus DB yang lebih dari 7 hari
hapusfiledb = $PathDB-$(date +%Y%m%d --date="7 hari yang lalu").sql
cd $PathDB
rm -rf $namafiledb

//Melakukan proses backup
echo "Backup database terakhir"
mysqldump --opt -u $UserDB --password="${PassDB}" $NameDB > $namafiledb
echo "Backup Selesai..."

//Commit ke Gitlab
git add .
echo "commit ke remote git"
git commit -am "Database Update"
git push -u origin master
echo "Menghapus Database Minggu terakhir"
rm -rf $hapusfiledb
