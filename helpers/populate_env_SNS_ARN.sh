#!/bin/sh
export SNS_ARN=`aws cloudformation describe-stacks --stack-name cf-notify | jq ".Stacks[].Outputs[].OutputValue"  | tr -d '"'`
