#!/bin/bash

# To Change the city to be queryed you can update the variable column_number with the column number of city
column_number=10

city_name=`cat crimedata-australia.csv | cut -d "," -f $column_number | head -1`

no_of_records=`tail crimedata-australia.csv -n +2| wc -l`

crime_sum=`cat crimedata-australia.csv | cut -d "," -f 1,10 crimedata-australia.csv | tail -n +2 | sort --field-separator=',' --key=2 -nr | awk -F',' '{sum+=$2;}END{print sum;}'`

avg_crime=`echo "scale=2 ; $crime_sum/$no_of_records" | bc`

echo "The average crime for $city_name is $avg_crime"
