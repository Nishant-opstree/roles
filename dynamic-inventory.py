import boto3
import json
import sys

ec2 = boto3.client("ec2")
hostIps = []
instance_tag_name = sys.argv[1]
def getNumberOfHosts(ec2, nameTag):
    instances = ec2.describe_instances(Filters=[
            {
                'Name': 'tag:Name',
                'Values': [
                    nameTag,
                ],
            },
        ])['Reservations']

    return len(instances)

def getHostsIp(ec2, nameTag, index):
    instanceIp = ec2.describe_instances(Filters=[
            {
                'Name': 'tag:Name',
                'Values': [
                    nameTag,
                ],
            },
        ])['Reservations'][index]['Instances'][0]['PrivateIpAddress']

    return instanceIp

numberOfHost = getNumberOfHosts(ec2, instance_tag_name)
for hostIndex in range(numberOfHost):
    hostIps.append(getHostsIp(ec2, instance_tag_name, hostIndex))

for host in hostIps:
    print(host)
