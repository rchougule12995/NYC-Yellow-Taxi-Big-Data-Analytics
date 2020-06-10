Copy this entire folder: RohitJyotibaChougule_19200240 to the directory "/home/UserName/" of your machine.

1. BASH for Big Data Analysis-(All the scripts to be run from the same folder to get access to the data file)
1.1) Run the script q1_1.sh in the folder Q1_Shell-scripts.
1.2) Run the script q1_2.sh in the folder Q1_Shell-scripts.
1.3) Run the script q1_3.sh in the folder Q1_Shell-scripts.
1.4) Run the script q1_4.sh in the folder Q1_Shell-scripts.
1.5) Run the script q1_5.sh in the folder Q1_Shell-scripts.
1.6) Run the script q1_6.sh in the folder Q1_Shell-scripts.

2. Data Management

2.1) Answer described in the report.

2.2 & 2.3) Database creation script and table population script in the q2_2_sql_script.sh file, which should be run from the same folder.
Specify the username as an argument when executing the script, and enter password when prompted.
ER Diagram for the database is created in the report.

2.4) Execute the script q2_4_mongo.sh
Specify the username as an argument when executing the script, and enter password when prompted. 
You will be prompted for the password twice as two collections are being created and it wont be a good idea to store password in a file.

SQL SELECT Queries and their results are saved in the file: q2_sql_select.sql

Mongo Searches and their results are saved in the file: q2_mongo_searches.js

3. Detailed description for answer to section 3 is in the report.

4. Hadoop:

Start your docker by using the below command:

sudo docker exec -it namenode bash

Copy the content of each java file(Question1.java to Question5.java) into the a java file, use the same file name to the file(Question1/2/3/4/5) when creating.
Alternatively, you can copy all these java files to your docker.

export HADOOP_CLASSPATH=/usr/lib/jvm/java-1.8.0-openjdk-amd64/lib/tools.jar

Follow the below commands to run all the map-reduce programs by following the same syntax, an example given below shows how to run Question1.java. Same can 
be followed for Question2, Question3, Question4, Question5

hadoop com.sun.tools.javac.Main Question1.java

jar cf Question1.jar Question1*.class

hadoop jar Question1.jar Question1 /input /output1

hdfs dfs -cat /output1/part-r*