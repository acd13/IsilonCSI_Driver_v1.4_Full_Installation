#!/bin/bash
#Author: Anjan Dave
#Version: 1.0
#There are no arguments to this script, just run it

#Start of script
#Check that we have more than 1 CPUs otherwise cannot proceed
nocpus=`lscpu | grep CPU"(s)": | grep -v NUMA | awk '{print $2}'`
if [ $nocpus -eq 1 ]
then
printf "You only have 1 CPU defined which is not enough, increase to at least 2 and then run the script again\n"
exit 0
fi


echo "Starting script to install docker..."
sleep 2


printf "\n=====Let's disable Swap first, using swapoff -a and edit the /etc/fstab file..."
swapoff -a
printf "\n Did a swapoff -a. Next let's edit the /etc/fstab to comment out the swap line...\n"

cat /etc/fstab | grep swap | grep "#"
if [ $? -eq 0 ]
then
printf "\nLooks like /etc/fstab line for swap is already commented out, see below"
cat /etc/fstab | grep swap
else
printf "\nWe need to comment out the swap line in /etc/fstab"
sed -i 's|\/dev\/mapper\/centos_k8s--faction-swap|#\/dev\/mapper\/centos_k8s--faction-swap|g' /etc/fstab
printf "\nCheck below line to make sure my sed did it's job, i.e., put a comment on the swap line:\n"
cat /etc/fstab | grep swap
fi
sleep 3

printf "\nInstalling yum utilities first..."
printf "\n Command is: yum install -y yum-utils device-mapper-persistent-data lvm2"
sleep 3
yum install -y yum-utils device-mapper-persistent-data lvm2

printf "\n\nNext is to install a docker repo, continue? yes/no:"
read ans
if [ $ans = yes ]
then
printf "\n\nNext step - install repo: yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo"
sleep 2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
fi

dockerv=`docker version | grep -i Version`
printf "\n\nDocker version $dockerv is installed"
echo ""
printf "\nNext is to install docker latest version. Continue further? yes/no:"
read ans2
if [ $ans2 = yes ]
then
printf "\nNow installing docker latest version: yum install docker-ce docker-ce-cli containerd.ioa"
sleep 2
yum install docker-ce docker-ce-cli containerd.io
fi

sleep 2

printf "\n\nLet's see what docker version we got:"
docker version

sleep 4

printf "\n\nNow let's make sure docker service is started: systemctl start docker"
systemctl start docker

printf "\n\nNow let's make sure the service will start with the host reboots: systemctl enable docker.service"
systemctl enable docker.service

sleep 4

printf "\n\nNow let's see if we can run a container on our Docker installation"
docker run hello-world

