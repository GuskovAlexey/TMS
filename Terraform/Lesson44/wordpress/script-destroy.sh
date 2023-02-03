#!/bin/bash


cd ALB/
terraform destroy -auto-approve &&

cd ../services &&
terraform destroy -auto-approve &&

cd ../bastion &&
terraform destroy -auto-approve &&

cd ../network &&
terraform destroy -auto-approve &&

cd ../ &&
cp /dev/null varspacker