#!/bin/bash

echo "Retrieving project variables from .env"
export $(cat .env | xargs)

COMMAND=$1

echo "Selecting AWS profile by project name."
export AWS_PROFILE=$PROJECT_NAME

echo "Retrieving a task arn for a single running service container."
TASK_ARN=$(aws ecs list-tasks --region $AWS_REGION --cluster $STACK-$ENV-$APP --service $STACK-$ENV-$APP-app --query 'taskArns[0]' --output text)

echo $TASK_ARN

echo "Running command on a container by task arn."
aws ecs execute-command --region $AWS_REGION --cluster $STACK-$ENV-$APP --container $CONTAINER --command "$COMMAND" --interactive --task $TASK_ARN

# Mail::raw('Hello World!', function($msg) {$msg->to('jaylong255@gmail.com')->subject('Test Email'); });


