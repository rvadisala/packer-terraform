#!/bin/sh
echo "Preparing Golden Ami"
PACKER_ARTIFACT=`/usr/local/bin/packer build -machine-readable ami.json | awk -F, '$0 ~/artifact,1,id/ {print $NF}'`
echo " "
echo "*************************************************"
echo $PACKER_ARTIFACT
echo " "
echo "*************************************************"
AMI_ID=`echo $PACKER_ARTIFACT | cut -d ':' -f2`
echo $AMI_ID
echo 'variable "AMI_ID_PACKER" { default = "'${AMI_ID}'" }'  > amivar.tf
echo "*************************************************"
echo " "
terraform init
echo "terraform initialized"
echo " "
terraform apply -auto-approve
