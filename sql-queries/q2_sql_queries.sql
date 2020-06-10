-- Question- 1
SELECT surname, minutes, team, passes FROM players WHERE team like '%ia%' and minutes<200 and passes>100;
-- +------------+---------+--------+--------+
-- | surname    | minutes | team   | passes |
-- +------------+---------+--------+--------+
-- | Kuzmanovic |     180 | Serbia |    103 |
-- +------------+---------+--------+--------+
-- 1 row in set (0.00 sec)

-- Question- 2
SELECT surname, shots FROM players WHERE shots>20 ORDER BY shots DESC;
-- +---------+-------+
-- | surname | shots |
-- +---------+-------+
-- | Gyan    |    27 |
-- | Villa   |    22 |
-- | Messi   |    21 |
-- +---------+-------+
-- 3 rows in set (0.00 sec)


-- Question- 3
SELECT p.surname, p.team, p.minutes FROM players p inner join teams t ON p.team = t.team WHERE p.position LIKE "goalkeeper" AND t.games > 4;
-- +--------------+-------------+---------+
-- | surname      | team        | minutes |
-- +--------------+-------------+---------+
-- | Romero       | Argentina   |     450 |
-- | Julio Cesar  | Brazil      |     450 |
-- | Neuer        | Germany     |     540 |
-- | Kingson      | Ghana       |     510 |
-- | Stekelenburg | Netherlands |     540 |
-- | Villar       | Paraguay    |     480 |
-- | Casillas     | Spain       |     540 |
-- | Muslera      | Uruguay     |     570 |
-- +--------------+-------------+---------+
-- 8 rows in set (0.00 sec)

-- Question- 4
SELECT count(*) AS SUPERSTAR FROM players p inner join teams t ON p.team = t.team WHERE t.ranking<10 AND p.minutes>350;
-- +-----------+
-- | SUPERSTAR |
-- +-----------+
-- |        54 |
-- +-----------+
-- 1 row in set (0.00 sec)

-- Question- 5
SELECT position, AVG(p.passes) AS Average_Passes FROM players p inner join teams t ON p.team = t.team WHERE p.position LIKE "forward" OR p.position LIKE "midfielder" GROUP BY p.position;
-- +------------+----------------+
-- | position   | Average_Passes |
-- +------------+----------------+
-- | forward    |        50.8252 |
-- | midfielder |        95.2719 |
-- +------------+----------------+
-- 2 rows in set (0.00 sec)


-- Question- 6
SELECT t1.team, t1.goalsFor, t1.goalsAgainst, t2.team, t2.goalsFor, t2.goalsAgainst FROM teams t1, teams t2 WHERE t1.goalsFor = t2.goalsFor AND t1.goalsAgainst = t2.goalsAgainst AND t1.team < t2.team;
-- +-----------+----------+--------------+--------------+----------+--------------+
-- | team      | goalsFor | goalsAgainst | team         | goalsFor | goalsAgainst |
-- +-----------+----------+--------------+--------------+----------+--------------+
-- | Australia |        3 |            6 | Denmark      |        3 |            6 |
-- | Cameroon  |        2 |            5 | Greece       |        2 |            5 |
-- | Chile     |        3 |            5 | England      |        3 |            5 |
-- | Chile     |        3 |            5 | Nigeria      |        3 |            5 |
-- | Chile     |        3 |            5 | South Africa |        3 |            5 |
-- | England   |        3 |            5 | Nigeria      |        3 |            5 |
-- | England   |        3 |            5 | South Africa |        3 |            5 |
-- | Italy     |        4 |            5 | Mexico       |        4 |            5 |
-- | Nigeria   |        3 |            5 | South Africa |        3 |            5 |
-- +-----------+----------+--------------+--------------+----------+--------------+
-- 9 rows in set (0.01 sec)


-- Question- 7
SELECT team, MAX(goalsFor/goalsAgainst) AS GoalRatio FROM teams GROUP BY team ORDER BY GoalRatio DESC LIMIT 1;
-- +----------+-----------+
-- | team     | GoalRatio |
-- +----------+-----------+
-- | Portugal |    7.0000 |
-- +----------+-----------+
-- 1 row in set, 1 warning (0.01 sec)


-- Question- 8
SELECT t.team, AVG(p.passes) AS average_pass FROM teams t INNER JOIN players p ON t.team = p.team WHERE p.position LIKE "defender" GROUP BY t.team HAVING average_pass > 150 ORDER BY average_pass DESC;
-- +-------------+--------------+
-- | team        | average_pass |
-- +-------------+--------------+
-- | Spain       |     213.0000 |
-- | Brazil      |     190.0000 |
-- | Germany     |     189.8333 |
-- | Netherlands |     182.5000 |
-- | Mexico      |     152.1429 |
-- +-------------+--------------+
-- 5 rows in set (0.00 sec)
