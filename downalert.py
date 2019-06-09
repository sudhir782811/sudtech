import boto3

client = boto3.client('sns')

def lambda_handler(event, context):
    topic_arn = 'arn:aws:sns:us-east-2:131081180442:PRODALERT'
    message = 'Server Down please chek immediately'
    client.publish(TopicArn=topic_arn,Message=message)
