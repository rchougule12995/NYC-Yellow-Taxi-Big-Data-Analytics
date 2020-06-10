#!/bin/bash

#$1 is the username that you need to enter when running the script
mysql -u $1 -p $1 <<EOF
use kane;

CREATE TABLE teams(team VARCHAR(20) PRIMARY KEY, ranking INT NOT NULL, games INT NOT NULL, wins INT NOT NULL, draws INT NOT NULL, losses INT NOT NULL, goalsFor INT NOT NULL, goalsAgainst INT NOT NULL, yellowCard INT NOT NULL, redCards INT NOT NULL);

CREATE TABLE players(player_id INT AUTO_INCREMENT PRIMARY KEY, surname VARCHAR(30) NOT NULL, team VARCHAR(30), position VARCHAR(20),  minutes INT, shots INT, passes INT, tackles INT, saves INT, FOREIGN KEY (team) REFERENCES teams(team));

load data local infile 'Teams.csv' into table teams fields terminated by ',' lines terminated by '\n';

load data local infile 'Players.csv' into table players fields terminated by ',' lines terminated by '\n'
(surname, team, position, minutes, shots, passes, tackles, saves);

EOF

echo "Tables created and added the data successfully"
