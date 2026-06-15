#!/bin/bash

DATA=$(date +"%Y%m%d_%H%M%S")

mysqldump -u root -p petvida > backups/petvida_$DATA.sql

echo "Backup criado: backups/petvida_$DATA.sql"