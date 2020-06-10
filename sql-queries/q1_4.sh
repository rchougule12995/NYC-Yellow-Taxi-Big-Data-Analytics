#!/bin/bash

# To Change the city to be queryed you can update the variable column_number with the column number of city
column_number=10

city_name=`cat crimedata-australia.csv | cut -d "," -f $column_number | head -1`

crime_sum=`cat crimedata-australia.csv | cut -d "," -f 1,$column_number crimedata-australia.csv | tail -n +2 | sort --field-separator=',' --key=2 -nr | awk -F',' '{sum+=$2;}END{print sum;}'`

echo "The total number of crimes for $city_name is $crime_sum"
