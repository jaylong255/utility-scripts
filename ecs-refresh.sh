#!/bin/bash

echo "Retrieving project variables from .env"
export $(cat .env | xargs)

echo "Selecting AWS profile by project name."
export AWS_PROFILE=$PROJECT_NAME

aws ecs update-service --cluster $PROJECT_NAME-$ENV-$APP --service $PROJECT_NAME-$ENV-$APP-app --force-new-deployment

