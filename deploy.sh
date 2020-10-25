#!/bin/sh
set -ex

SECURITY_GROUP_ID="sg-01b96874d03a9282f"
IP=`curl -f -s ifconfig.me`

trap "aws ec2 revoke-security-group-ingress --region ap-northeast-1 --group-id ${SECURITY_GROUP_ID} --protocol tcp --port 22 --cidr ${IP}/32" 0 1 2 3 15
aws ec2 authorize-security-group-ingress --region ap-northeast-1 --group-id ${SECURITY_GROUP_ID} --protocol tcp --port 22 --cidr ${IP}/32
bundle exec cap production deploy