#!/bin/bash
host_tag="attendance"
key_path="~/.jenkins/ec2-linux-public-01.pem"
service_name="attendance"
host_ips=($(python dynamic-inventory.py $host_tag))
for host_ip in "${host_ips[@]}"
do
        application_present=$(ssh -o "StrictHostKeyChecking no" -i $key_path ubuntu@$host_ip """if [ -d /usr/local/$service_name ]
then
        echo "true"
else
        echo "false"
fi """)
if [ $application_present == "true" ]
then    
        echo "true"
        scp -i $key_path -r ubuntu@$host_ip:/usr/local/$service_name .
else    
        echo "false"
fi
done
