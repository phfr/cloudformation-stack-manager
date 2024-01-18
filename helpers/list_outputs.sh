#!/bin/sh
aws cloudformation describe-stacks --stack-name livestreaming | jq '.Stacks | .[] | .Outputs | reduce .[] as $i ({}; .[$i.OutputKey] = $i.OutputValue)'
