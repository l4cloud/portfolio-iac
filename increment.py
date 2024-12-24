import json
import boto3

def lambda_handler(event, context):

    table = boto3.resource('dynamodb').Table('visitors')

    try:
        # Add one to the counter and ask for the new value to be returned
        response = table.update_item(
            Key={'exampleHashKey': 'main'},
            UpdateExpression="ADD #cnt :val",
            ExpressionAttributeNames={'#cnt': 'count'},
            ExpressionAttributeValues={':val': 1},
            ReturnValues="UPDATED_NEW"
        )
        return response["Attributes"]["count"]
        
    except Exception as e:
        return {
            print(json.dumps({'error': str(e)}))
        }
        

