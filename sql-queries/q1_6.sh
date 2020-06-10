#!/bin/bash

min_avg=1000
city_index=0
Num_col=`head -1 crimedata-australia.csv | sed 's/[^,]//g' |wc -c`
cities=`expr $Num_col-1 | bc`

for i in $(seq 3 $cities)
do
	totalCrimes=`cat crimedata-australia.csv  | cut -d, -f$i | awk '{total += $0} END{print total}'`
	totalLines=`tail crimedata-australia.csv -n +2| wc -l`
	avg=`echo "scale=2;$totalCrimes/$totalLines"|bc`
#	echo $avg
#	echo "$min_avg > $avg"
#	if [ $min_avg < $avg ]
	if [ "$(echo "$min_avg > $avg" | bc)" -eq 1 ] 
	then
		min_avg=$avg
		city_index=$i
			
	fi
done
cityName=`cat crimedata-australia.csv | head -1 | cut -d, -f$city_index`
echo "Minimum Average Crimes is for $cityName = $min_avg"  
