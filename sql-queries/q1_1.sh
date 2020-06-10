#!/bin/bash

line_count=`tail crimedata-australia.csv -n +2| wc -l`
echo "The Number of lines in the file are: $line_count"
