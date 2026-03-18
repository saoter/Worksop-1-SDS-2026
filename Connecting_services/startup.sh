#!/bin/bash

echo "--------------------------------------"
echo "Starting VS Code environment setup..."
echo "--------------------------------------"

echo ""
echo "1. Updating package list..."
sudo apt update

echo ""
echo "2. Installing MySQL client..."
sudo apt install mysql-client -y

echo ""
echo "3. Checking whether mysql client is installed..."
mysql --version


echo ""
echo "4. Testing connection to SQL server hostname: sql-net"
ping -c 2 sql-net || echo "Could not ping sql-net. Check if VS Code is connected to the SQL job."



echo ""
echo "--------------------------------------"
echo "Setup complete."
echo "You can now connect using:"
echo "mysql -h sql-net -u clientuser -p course_db"
echo "and then"
echo "SELECT * FROM users;"
echo "--------------------------------------"

