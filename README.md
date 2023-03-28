# Utility Scripts
In the process of doing work for clients, I end up writing little utilities in Bash or Python to help automate or improve my productivity. I'm usually in a huge hurry and a lot of sensitive or nuanced bits get hard-coded. This repo is an attempt to abstract these bits in the more useful utilities so that they can be reused and shared with other developers on different teams. 

---

## Run Commands on Environments Powered by Amazon ECS Service
Environments that run on container clusters are dope. Sometimes you need to run commands on them. Most developers are familiar with using SSH to log into a virtual server machine to run command line commands on an environment. Containers are a little different, though. ECS (specifically with Fargate) has a nifty way of interacting with environments using their Systems Manager service. It's called "ECS Exec". More detailed information can be found [here](https://aws.amazon.com/blogs/containers/new-using-amazon-ecs-exec-access-your-containers-fargate-ec2/).

One painful and time-consuming issue with this command is that you need to pass in the task ARN. It sounds simple and easy enough to look this up through the console or through the CLI. However, when you need to do this a lot it becomes tedious. Then when you factor in multiple enviornments and the fact that deployments, autoscaling and health checks cause these tasks to constantly rebuild it becomes mostly impractical. 

The `ecs-cmd.sh` script is a simple Bash script that uses the AWS CLI to retrieve a task ARN for a running task in a given enviornment and then use that value to run an input command on said task. Just set the values in your .env file and execute one command and that's it. 

### Sample Command

This command will put you inside the container specified in your .env so you can run commands on the command line of a running task in the cloud. This is handy when you need to run multiple commands.

```bash
# Launching a Shell
./ecs-cmd.sh /bin/sh
```
---
## Setup


### AWS Authentication
Each of these scripts expects that you have the AWS CLI installed and profiles set up. Detailed instructions can be found in the following docs:

- [Installing or updating the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Named profiles for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

Once you have these set up, you're ready to configure your `.env` file. Copy the `.sample.env` file to `.env`.

```bash
# Copy the sample env file
cp .sample.env .env
```

Update the values in `.env`. 

```bash
# This should match the name of the profile you created for AWS credentials.
PROJECT_NAME=myproject

# The id for the account where your project lives
AWS_ACCOUNT_ID=1234567890123

# The region where a given enviornment lives
AWS_REGION=us-east-1

# My stacks follow a naming convention that usually starts all names with a slug of the product name or product umbrella name
STACK=myawesomestack

# This refers to enviornment types. This is either development or production, where a staging app would fall under development type. 
# NOTE: I may change this to a production or development bool in the future.
ENV=dev

# The unique name of the environment.
APP=staging

# Which container you want to interact with. This should match the container name in the task definition. The example is a Django app. On Laravel and Symfony apps, I usually just call it PHP. 
CONTAINER=django
```

Handling mulitple environments.

```bash
# Make a copy for multiple enviornments and update them with respect to their required region, env, and app values. (All of these files are ignored by git, so unless you choose a different name, your sensitive information will not be committed)
# NOTE: if you wish to add support for another file name, feel free to submit a PR and I'll review it.
cp .env .env.dev
cp .env .env.prod

# Switching to dev env
cat .env.dev > .env

# Switching to prod env
cat .env.prod > .env
```