#!/bin/bash

cp /dev/null varspacker
cp /dev/null packer/front/variables.auto.pkrvars.hcl &&
echo -e 'db_name = "wordpress" \ndb_user = "wordpress" \ndb_pass = "wordpress"' > packer/back/variables.auto.pkrvars.hcl &&


cd network/
terraform apply -auto-approve &&
terraform output -state=<terraform.tfstate> -json > ../varspacker &&
sed -n '/vpc_id/p' ../varspacker >> ../packer/back/variables.auto.pkrvars.hcl &&
sed -n '/vpc_id/p' ../varspacker >> ../packer/front/variables.auto.pkrvars.hcl &&
sed -n '/subnet_id_priv/p' ../varspacker >> ../packer/back/variables.auto.pkrvars.hcl &&
sed -n '/subnet_id_priv/p' ../varspacker >> ../packer/front/variables.auto.pkrvars.hcl &&

cd ../bastion &&
terraform apply -auto-approve  &&
terraform output -state=<terraform.tfstate> -json >> ../varspacker &&
sed -n '/pub_ip_bastion/p' ../varspacker >> ../packer/front/variables.auto.pkrvars.hcl &&
sed -n '/pub_ip_bastion/p' ../varspacker >> ../packer/back/variables.auto.pkrvars.hcl &&
sed -n '/sg_allow_ssh_from_bastion/p' ../varspacker >> ../packer/front/variables.auto.pkrvars.hcl &&
sed -n '/sg_allow_ssh_from_bastion/p' ../varspacker >> ../packer/back/variables.auto.pkrvars.hcl &&

cd ../services &&
terraform apply -auto-approve  &&
terraform output -state=<terraform.tfstate> -json >> ../varspacker &&
sed -n '/efs_address/p' ../varspacker >> ../packer/back/variables.auto.pkrvars.hcl &&
sed -n '/rds_address/p' ../varspacker >> ../packer/back/variables.auto.pkrvars.hcl 
# add at the end of the rds_address - :3306

cd ../ALB
terraform apply -auto-approve  &&
terraform output -state=<terraform.tfstate> -json >> ../varspacker &&
sed -n '/nginx_wordpress_conf_wordpress_back_lb_url/p' ../varspacker >> ../packer/front/variables.auto.pkrvars.hcl 
# add before alb_url http://

cd ../packer/back &&
packer build . &&

cd ../front &&
packer build . &&

cd ../launch-templates &&
terraform apply -auto-approve &&

cd ../ASG &&
terraform apply -auto-approve 