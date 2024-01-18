#!/bin/sh

# not relevant for stack delete, but should be there anyways
echo "making sure that the cloudformation-notification-framework is deployed already ..."
CFNOTIFY_ARN=`aws cloudformation describe-stacks --stack-name cf-notify | jq ".Stacks[].Outputs[].OutputValue"  | tr -d '"'`

if [ -z $CFNOTIFY_ARN ];
then
    echo "cloudformation-notification-stack SNS not found (run deployment script first)";
    exit 1
fi

echo "... done. using: '$CFNOTIFY_ARN'"

# aws cloudformation create-stack --stack-name livestreaming --template-body file://stacks/livestreaming.yaml --parameters file://stacks/livestreaming.params --notification-arns arn:aws:sns:us-east-1:550424385458:cf-notify-CFNotifyTopic-1GGHTPKG0U8WW --capabilities CAPABILITY_IAM

aws cloudformation delete-stack --stack-name livestreaming  
