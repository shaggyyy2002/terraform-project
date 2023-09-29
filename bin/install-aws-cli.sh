#!/bin/bash

cd /workspace

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

./aws/install -i /usr/local/aws-cli -b /usr/local/bin

aws --version

sudo apt update

cd $PROJECT_ROOT