#!/bin/bash

mongoimport -u $1 -p  --db $1 -c Players -type csv -headerline --file /home/$1/RohitJyotibaChougule_19200240/Players.csv
	
mongoimport -u $1 -p  --db $1 -c Teams -type csv -headerline --file /home/$1/RohitJyotibaChougule_19200240/Teams.csv

echo "Collections created successfully"
