import boto3
import os
region = 'ap-south-1'
instances=['i-0f834339c52a6e0a9']
#instances = os.environ['INSTANCE_ID']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print('started your instances: ' + str(instances))