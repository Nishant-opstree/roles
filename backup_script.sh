#!/bin/bash
host_tag=$1
key_path=$2
service_name=$3
host_ips=($(python dynamic-inventory.py $host_tag))
for host_ip in "${host_ips[@]}"
do
        application_present=`ssh -o "StrictHostKeyChecking no" -i $key_path ubuntu@$host_ip "if [ -d /usr/local/$service_name ] ; then echo "true"; else echo "false" ; fi "`
	echo "$application_present 1"
if [ $application_present == "true" ]
then    
        echo "true2"
        scp -i $key_path -r ubuntu@$host_ip:/usr/local/$service_name .
else    
        echo "false2"
fi
done
