#!/bin/bash

column_count=`head -1 crimedata-australia.csv | sed 's/[^,]//g' | wc -c`

echo "The number of columns in the file are: $column_count"
