#!/bin/bash

TOTAL_URL='wc -l sources'

while read URL 
do 
	wget $URL
done < sources


