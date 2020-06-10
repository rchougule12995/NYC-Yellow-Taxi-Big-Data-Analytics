#!/bin/bash

# To Change the city to be queryed you can update the variable column_number with the column number of city
column_number=10

city_name=`cat crimedata-australia.csv | cut -d "," -f $column_number | head -1`

top_crime_row=`cat crimedata-australia.csv | cut -d "," -f 1,$column_number crimedata-australia.csv | tail -n +2 | sort --field-separator=',' --key=2 -nr | head -1`

top_crime=`echo $top_crime_row | cut -d "," -f 1`

top_crime_count=`echo $top_crime_row | cut -d "," -f 2`
echo "The crime on the top of list for $city_name is: "$top_crime

echo "There are $top_crime_count occurrences of $top_crime in $city_name"
