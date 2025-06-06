import boto3
import os
region = 'ap-south-1'
#instances=['i-0f834339c52a6e0a9']
instances = os.environ.get('INSTANCE_ID')
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instances)
    print('stopped your instances: ' + str(instances))