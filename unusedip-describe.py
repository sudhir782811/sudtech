mport boto3
client = boto3.client('ec2')
def lambda_handler(event, context):
    ipresp = client.describe_addresses()
    for i in ipresp['Addresses']:
        if 'InstanceId' in i:
            print('{} this is in use'.format(i['PublicIp']))
        
