import boto3
import json
client = boto3.client('ec2')
snsclient = boto3.client('sns')

def lambda_handler(event, context):
    volresp = client.describe_volumes()
    volumes = []
    for vol in volresp['Volumes']:
        print(vol['VolumeId'])
        volumes.append(vol['VolumeId'])
        
    client.create_snapshot(
        VolumeId = vol['VolumeId'],
        Description = "boto3"+vol['VolumeId']
