import boto3
client = boto3.client('ec2')
snsClient = boto3.client('sns')
def lambda_handler(event, context):
    volResp = client.describe_volumes()
    volumeIds = []
    snapshotIds = []
    for i in volResp['Volumes']:
        print(i['VolumeId'])
        volumeIds.append(i['VolumeId'])
        
        snapResp = client.create_snapshot(
            VolumeId = i['VolumeId']
            )
        snapshotIds.append(snapResp['SnapshotId'])
        
#sending email

snsClient.publish(
    TopicArn='arn:aws:sns:eu-central-1:006594528287:alert',
    Message= 'snapshot has been created'
    )
