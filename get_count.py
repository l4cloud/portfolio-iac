import json
import boto3

def lambda_handler(event, context):
    table = boto3.resource('dynamodb').Table('visitors')
    response = table.get_item(Key={'exampleHashKey': 'main'})
    return response['Item']['count']
    
