#!/bin/bash

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y

# install docker community edition
apt-cache policy docker-ce
apt-get install -y docker-ce

apt install -y python3-pip
pip3 install awscli

aws ecr get-login-password --region sa-east-1

# if docker in not aG group use sudo
aws ecr get-login-password \
  --region sa-east-1 | sudo docker login --username AWS --password-stdin \
  {{AWS_ACCOUNT_ID}}.aws_url

sudo docker run -d -p 80:80 \
  --name webapp {{AWS_ACCOUNT_ID}}.dkr.ecr.sa-east-1.amazonaws.com/{your_repo:your_image}
