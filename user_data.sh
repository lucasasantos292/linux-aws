#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install git
sudo yum install amazon-nfs-utils
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-093a34d287a90fdf5.efs.us-east-1.amazonaws.com:/ /mnt/efs


