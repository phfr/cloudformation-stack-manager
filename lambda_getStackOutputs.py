import json
import boto3
import datetime
 

def myconverter(o):
    if isinstance(o, datetime.datetime):
        return o.__str__()

def lambda_handler(event, context):
    
    
    stack_name = event['stackName']

    client = boto3.client('cloudformation')
    resources = client.describe_stacks(StackName=stack_name)
    
    outputs = resources['Stacks'][0]['Outputs']

    report =   {  output["OutputKey"]: output["OutputValue"] 
        for output in outputs}


    return {
        'statusCode': 200,
        'body': json.dumps(report, default = myconverter)
    }
