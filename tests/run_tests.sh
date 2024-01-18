#!/bin/sh
# create/delete stacks to test cf notification handler

PAUSE="60"

echo "getting arn of SNS cf handler: \c"
SNS_ARN=`aws cloudformation describe-stacks --stack-name cf-notify | jq ".Stacks[].Outputs[].OutputValue"  | tr -d '"'`
echo $SNS_ARN

echo "waiting 10 seconds before starting ..."
sleep 10


# FAIL test
echo "running test that should FAIL ..."
aws cloudformation create-stack --stack-name cf-notify-test-FAIL --template-body file://tests/failure.yaml --notification-arns $SNS_ARN

echo "sleeping $PAUSE seconds"
sleep $PAUSE


# SUCCESS test
echo "running test that should SUCCEED"
aws cloudformation create-stack --stack-name cf-notify-test-SUCCESS --template-body file://tests/success.yaml --parameters "ParameterKey=BucketName,ParameterValue=testing-cloud-formation-sns-$(date +%s)" --notification-arns $SNS_ARN

echo "sleeping $PAUSE seconds"
sleep $PAUSE


# delete stacks
echo "deleting FAIL test"
aws cloudformation delete-stack --stack-name cf-notify-test-FAIL

echo "sleeping $PAUSE seconds"
sleep $PAUSE

echo "deleting SUCCESS test"
aws cloudformation delete-stack --stack-name cf-notify-test-SUCCESS
