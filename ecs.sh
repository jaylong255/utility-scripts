#!/bin/bash

echo "Retrieving project variables from .env"
export $(cat .env | xargs)

COMMAND=$1

echo "Selecting AWS profile by project name."
export AWS_PROFILE=$PROJECT_NAME

echo "Retrieving a task arn for a single running service container."
TASK_ARN=$(aws ecs list-tasks --region $REGION --cluster $PROJECT_NAME-$ENV-$APP --service $PROJECT_NAME-$ENV-$APP-app --query 'taskArns[0]' --output text)

echo $TASK_ARN

echo "Running command on a container by task arn."
aws ecs execute-command --region $REGION --cluster $PROJECT_NAME-$ENV-$APP --container $CONTAINER --command "$COMMAND" --interactive --task $TASK_ARN
