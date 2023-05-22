if [ ! -d "/var/lib/mysql/$SQL_DATABASE" ]; then

# start mysql
service mysql start
sleep 5
mysql_secure_installation << EOF
y
$SQL_ROOT_PASSWORD
$SQL_ROOT_PASSWORD
y
y
y
y
EOF

# Create Database if not exists
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create SQL-USER
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Give rights to the user SQL_USER with the password SQL_PASSWORD
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Refresh MySQL
mysql -e "FLUSH PRIVILEGES;"

# Shutdown MySQL for reboot
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

fi

# run the famous command that MySQL constantly recommends when it starts.
exec mysqld_safe 