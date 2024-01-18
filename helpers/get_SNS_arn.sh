#!/bin/sh
aws cloudformation describe-stacks --stack-name cf-notify | jq ".Stacks[].Outputs[].OutputValue"  | tr -d '"'


# aws cloudformation describe-stacks \
# --stack-name cf-notify \
# --output text \
# --query "Stacks[0].Outputs[0].OutputValue"
