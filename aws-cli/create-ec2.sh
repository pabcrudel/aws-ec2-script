#!/bin/bash

AWS_ID_GrupoSeguridad_EC2PABLOCRU=$(
  aws ec2 create-security-group \
  --group-name 'SecGroupEC2PABLOCRU' \
  --description 'Permitir conexiones SSH' \
  --output text
)

aws ec2 authorize-security-group-ingress \
--group-id $AWS_ID_GrupoSeguridad_EC2PABLOCRU \
--ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "Allow SSH"}]}]'

aws ec2 run-instances \
--image-id ami-050406429a71aaa64 \
--count 1  \
--instance-type m1.small \
--key-name vockey \
--region us-east-1 \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=EC2PABLOCRU}]' \
--security-group-ids $AWS_ID_GrupoSeguridad_EC2PABLOCRU
