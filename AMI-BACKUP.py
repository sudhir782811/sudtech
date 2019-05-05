import boto3

client = boto3.client('ec2')

def lambda_handler(event, context):

    response = client.create_image(
    BlockDeviceMappings=[
        {
    'DeviceName': '/dev/xvda',
    'VirtualName': 'web2',
    'Ebs': {
    'DeleteOnTermination': True,
    'VolumeType': 'standard',
            },},],
    Description='string',
    DryRun=False,
    InstanceId='i-074089abfa443b3e4',
    Name='web2',
    NoReboot=True
    )
