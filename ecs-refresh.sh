#!/bin/bash

echo "Retrieving project variables from .env"
export $(cat .env | xargs)

echo "Selecting AWS profile by project name."
export AWS_PROFILE=$PROJECT_NAME

aws ecs update-service --cluster $STACK-$ENV-$APP --service $STACK-$ENV-$APP-app --force-new-deployment --region $AWS_REGION


