#!/bin/bash

service_name=$1
ssh_key_path=$2
applications_instance_ip=(`python dynamic-inventory.py $service_name`)
echo [webapp] >> inventory
for application in "${applications_instance_ip[@]}"
do
    echo "$application ansible_user=ubuntu ansible_ssh_private_key_file=$ssh_key_path" >> inventory
done

