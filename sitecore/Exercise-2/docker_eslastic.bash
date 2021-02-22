#!/bin/bash
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -

sudo add-apt-repository \
    "deb https://apt.dockerproject.org/repo/ \
    ubuntu-$(lsb_release -cs) \
    main"

sudo apt-get update
sudo apt-get -y install docker-engine docker-compose

# add current user to docker group so there is no need to use sudo when running docker
sudo usermod -aG docker $(whoami)

#pull the elasticserach image
docker pull elasticsearch:7.7.1

#create a volume
docker volume create --name ealstic_volume

#run elasticsearch container
docker run -d --name elasticsearch -p 9300:9300 -p 9200:9200 -v ealstic_volume -e "discovery.type=single-node" elasticsearch:7.7.1

sleep 20

echo ""
#ealsticsearch Health check
echo "ealsticsearch Health check "
echo "------------------------------------------------------------"
curl localhost:9200/_cat/health

echo ""
echo "ealsticsearch Health check for cluster "
echo "------------------------------------------------------------"
curl localhost:9200/_cluster/health?pretty

