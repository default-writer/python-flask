#!/bin/bash -e
uid=$(id -u)

if [ ! "${uid}" -eq 0 ]
then
  echo "Please run as root"
  exit
fi

pwd=$(pwd)

install="$1"

if [ "${install}" == "build" ]
then
  sudo git config --global --add safe.directory ${pwd}
  sudo git config --global pull.rebase false

  sudo apt-get update
  sudo apt install -y build-essential curl git ca-certificates python3 python3-dev python3-pip python3-venv python3-behave
fi

if [ "${install}" == "docker" ]
then
  sudo apt-get update
  sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update -y
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  sudo apt-get update -y
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

cd ${pwd}