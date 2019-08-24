import boto3

client = boto3.client('ec2')
def lambda_handler(event, context):
    response = client.describe_volumes()
    for i in response['Volumes']:
        if 'VolumeId' in i and i['VolumeId'] == "vol-06fa3862df48c860e":
            print(i['VolumeId'])
            
            client.create_snapshot(
                VolumeId = i['VolumeId'],
                Description = "Boto3"+i['VolumeId']
                )
