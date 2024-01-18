## Overview

## cf-notify
This is a stack that creates a SNS Event and a lambda handler for it.
The SNS-Event-ARN should be passed to stack creations so the lambda handler gets notifications of stack creation events, can parse those and report to cloudwatch and slack. This is done because cloudformation does not support cloudwatch etc by default.

cf-notify only needs **one initial deployment action**, which happens by running deploy/deploy-cloudformation-notification-framework.sh

to get the created SNS run helpers/get_SNS_arn.sh


## Managing stacks

### creation of stacks

to for example create a live streaming stack and utilize cf-notify run: deploy/create-stack-livestreaming.sh
(this uses the stack definition in stacks/livestreaming.yaml with the parameters in stacks/livestreaming.param and registers to the SNS of cf-notify)
in the future this should be done programmatically and stackdeployer/ has a prototype lambda function

### deletion of stacks
to for example delete a live streaming stack run deploy/delete-stack-livestreaming.sh

### getting stack outputs
example for livestreaming stack is in helpers/list_outputs.sh


## future
* The idea is is to programmatically manage the creation and deletion of stacks on demand, in stackdeployer/ there is a prototype of a lambda function that does this by using stack definition and parameters from a s3 bucket, so we can have different stacks, with different configurations, versions etc. the idea is to pass an ID, so a livestreamingstack would for example be named livestreaming-{EventID}

* lambda_getStackOutputs.py shows how to get the stack outputs, this could be connected to an API Gateway, so we could get the stream URL by passing a stackid like livestreaming-{EventID}, this is deployed with a test defined (not connected to api-gateway yet)

## considerations
* security and api-gateway implementation, getting stack infos like output URL could probably be open
* maybe put cf-notify arn in SSM parameter store




