#!/bin/sh

# Replace/Add your regions in below variable list
region=("eu-west-3" "ap-southeast-1")
outputFile="InstanceTagsList.csv"

# Removing output file to overcome content overlap issues

if [ -f "$outputFile" ]; then
        rm -rf "$outputFile"
fi

# Getting List of instances into array and looping them..

for instance in ${region[@]};
do
#AWS CLI  command to get all tags details of each instance in a region
aws ec2 describe-tags --region $instance  --filters "Name=resource-type,Values=instance" | jq -r '.Tags[] | "\(.ResourceId),\(.Key),\(.Value)"' >> "$outputFile"
done


#Output
#   <Instance ID>,<Tag Key>,<Tag Value>
# This out put file will be stored into csv file as we redirected..
