import boto3
client = boto3.client('ec2',region_name='us-east-2')
def lambda_handler(event, context):
    resp = client.describe_instances()
    for reservation in resp['Reservations']:
        for instance in reservation['Instances']:
            print(instance['InstanceId'],instance['Placement'] ['AvailabilityZone'])
