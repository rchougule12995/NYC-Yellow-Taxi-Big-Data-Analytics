0yers.find({"team":/.*ia.*/, "minutes": {$lt:200}, "passes":{$gt:100}}, {"surname":1}).pretty()

//Output:
//{ "_id" : ObjectId("5e4dbdfd1d7790aa3d38d6a0"), "surname" : "Kuzmanovic" }

//-------------------------------------------------------------------------------------------------

// Question- 2
db.Players.find({"shots": {$gt:20}}).sort({shots:-1})

//Output:
//{
//        "_id" : ObjectId("5e4dbdfd1d7790aa3d38d5b9"),
//        "surname" : "Gyan",
//        "team" : "Ghana",
//        "position" : "forward",
//        "minutes" : 501,
//        "shots" : 27,
//        "passes" : 151,
//        "tackles" : 1,
//        "saves" : 0
//}
//{
//        "_id" : ObjectId("5e4dbdfd1d7790aa3d38d708"),
//        "surname" : "Villa",
//        "team" : "Spain",
//        "position" : "forward",
//        "minutes" : 529,
//        "shots" : 22,
//        "passes" : 169,
//        "tackles" : 2,
//        "saves" : 0
//}
//{
//        "_id" : ObjectId("5e4dbdfd1d7790aa3d38d50d"),
//        "surname" : "Messi",
//        "team" : "Argentina",
//        "position" : "forward",
//        "minutes" : 450,
//        "shots" : 21,
//        "passes" : 321,
//        "tackles" : 10,
//        "saves" : 0
//}

//-------------------------------------------------------------------------------------------------

// Question 3
var team_4 = db.Teams.find({games:{$gt:4}},{team:1}).toArray()
team_4.forEach(function(s){var GoalKeeper = db.Players.findOne({position:"goalkeeper",team:s.team});print(GoalKeeper.surname, GoalKeeper.team, GoalKeeper.minutes)})

//Output:
//Julio Cesar Brazil 450
//Casillas Spain 540
//Stekelenburg Netherlands 540
//Neuer Germany 540
//Romero Argentina 450
//Muslera Uruguay 570
//Villar Paraguay 480
//Kingson Ghana 510

//-------------------------------------------------------------------------------------------------

// Question 4

var teams_10 = db.Teams.find({ranking:{$lt:10}},{team:1}).toArray()
var teams_arr = new Array()
teams_10.forEach(function(myDoc) {teams_arr.push(myDoc.team)} )
db.Players.aggregate([
{$match:{$and:[{minutes:{$gt:350}},{team:{$in:teams_arr}}]}},
{$group:{_id: null, Superstar:{$sum:1}}},
{$project:{_id : 0 , Superstar : 1}}])

//Output:
//{ "Superstar" : 54 }

//-------------------------------------------------------------------------------------------------

// Question 5

db.Players.aggregate([
{$match:{$or:[{position:{$eq:"forward"}},{position:{$eq:"midfielder"}}]}},
{$group:{_id:"$position", average_passes:{$avg:"$passes"}}}])

//Output:
//{ "_id" : "forward", "average_passes" : 50.82517482517483 }
//{ "_id" : "midfielder", "average_passes" : 95.2719298245614 }

//-------------------------------------------------------------------------------------------------

// Question 6

var cursor = db.Teams.find({},{team:1,goalsFor:1,goalsAgainst:1})
cursor.forEach(function(Teams){
var s = db.Teams.find(
{team:{$lt:Teams.team}, goalsFor:Teams.goalsFor, goalsAgainst: Teams.goalsAgainst});
s.forEach(function(team2){print(Teams.team,team2.team, team2. goalsFor, team2.goalsAgainst);});})

//Output:
//England Chile 3 5
//Greece Cameroon 2 5
//Mexico Italy 4 5
//Nigeria England 3 5
//Nigeria Chile 3 5
//Denmark Australia 3 6
//South Africa England 3 5
//South Africa Chile 3 5
//South Africa Nigeria 3 5

//-------------------------------------------------------------------------------------------------

// Question 7

db.Teams.aggregate([
{"$project":{"team":1, "ratio":{"$divide":["$goalsFor", "$goalsAgainst"]}}}, 
{"$sort" : { "ratio" : -1.0 } }, {$limit:1}, {$project : { _id : 0 , team : 1 , ratio : 1}} ])

//Output:
//{ "team" : "Portugal", "ratio" : 7 }

//-------------------------------------------------------------------------------------------------

// Question 8

db.Players.aggregate([{$match:{position: "midfielder"}},
{$group:{_id: "$team", average_passes:{$avg:"$passes"}}},
{$match:{average_passes:{$gt: 150}}},{$project :{ _id : 0 ,team: "$_id" , average_passes:1}}]);

//Output:
//{ "average_passes" : 169.5, "team" : "Netherlands" }
//{ "average_passes" : 212.5, "team" : "Spain" }
//{ "average_passes" : 172.33333333333334, "team" : "Ghana" }
//{ "average_passes" : 151.71428571428572, "team" : "Argentina" }
//{ "average_passes" : 177.16666666666666, "team" : "Germany" }
