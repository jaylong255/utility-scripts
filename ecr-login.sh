#!/bin/bash

echo "Retrieving project variables from .env"
export $(cat .env | xargs)

aws ecr get-login-password | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${PROJECT_NAME}-${ENV}-${APP}
