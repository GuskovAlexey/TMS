#! /bin/bash

docker-machine create \
	--driver amazonec2 \
	--amazonec2-region eu-west-2 \
	--amazonec2-zone "a" \
	--amazonec2-ami ami-038d76c4d28805c09 \
	--amazonec2-instance-type t2.medium \
	--amazonec2-open-port 30100 \
	--amazonec2-open-port 80 \
	--amazonec2-open-port 8080 \
	--amazonec2-open-port 6443 \
k8s-wp



# Options:
   
#    --amazonec2-access-key                                                                               AWS Access Key [$AWS_ACCESS_KEY_ID]
#    --amazonec2-ami                                                                                      AWS machine image [$AWS_AMI]
#    --amazonec2-block-duration-minutes "0"                                                               AWS spot instance duration in minutes (60, 120, 180, 240, 300, or 360)
#    --amazonec2-device-name "/dev/sda1"                                                                  AWS root device name [$AWS_DEVICE_NAME]
#    --amazonec2-endpoint                                                                                 Optional endpoint URL (hostname only or fully qualified URI) [$AWS_ENDPOINT]
#    --amazonec2-iam-instance-profile                                                                     AWS IAM Instance Profile [$AWS_INSTANCE_PROFILE]
#    --amazonec2-insecure-transport                                                                       Disable SSL when sending requests [$AWS_INSECURE_TRANSPORT]
#    --amazonec2-instance-type "t2.micro"                                                                 AWS instance type [$AWS_INSTANCE_TYPE]
#    --amazonec2-keypair-name                                                                             AWS keypair to use; requires --amazonec2-ssh-keypath [$AWS_KEYPAIR_NAME]
#    --amazonec2-monitoring                                                                               Set this flag to enable CloudWatch monitoring
#    --amazonec2-open-port [--amazonec2-open-port option --amazonec2-open-port option]                    Make the specified port number accessible from the Internet
#    --amazonec2-private-address-only                                                                     Only use a private IP address
#    --amazonec2-region "us-east-1"                                                                       AWS region [$AWS_DEFAULT_REGION]
#    --amazonec2-request-spot-instance                                                                    Set this flag to request spot instance
#    --amazonec2-retries "5"                                                                              Set retry count for recoverable failures (use -1 to disable)
#    --amazonec2-root-size "16"                                                                           AWS root disk size (in GB) [$AWS_ROOT_SIZE]
#    --amazonec2-secret-key                                                                               AWS Secret Key [$AWS_SECRET_ACCESS_KEY]
#    --amazonec2-security-group [--amazonec2-security-group option --amazonec2-security-group option]     AWS VPC security group [$AWS_SECURITY_GROUP]
#    --amazonec2-security-group-readonly                                                                  Skip adding default rules to security groups [$AWS_SECURITY_GROUP_READONLY]
#    --amazonec2-session-token                                                                            AWS Session Token [$AWS_SESSION_TOKEN]
#    --amazonec2-spot-price "0.50"                                                                        AWS spot instance bid price (in dollar)
#    --amazonec2-ssh-keypath                                                                              SSH Key for Instance [$AWS_SSH_KEYPATH]
#    --amazonec2-ssh-user "ubuntu"                                                                        Set the name of the ssh user [$AWS_SSH_USER]
#    --amazonec2-subnet-id                                                                                AWS VPC subnet id [$AWS_SUBNET_ID]
#    --amazonec2-tags                                                                                     AWS Tags (e.g. key1,value1,key2,value2) [$AWS_TAGS]
#    --amazonec2-use-ebs-optimized-instance                                                               Create an EBS optimized instance
#    --amazonec2-use-private-address                                                                      Force the usage of private IP address
#    --amazonec2-userdata                                                                                 path to file with cloud-init user data [$AWS_USERDATA]
#    --amazonec2-volume-type "gp2"                                                                        Amazon EBS volume type [$AWS_VOLUME_TYPE]
#    --amazonec2-vpc-id                                                                                   AWS VPC id [$AWS_VPC_ID]
#    --amazonec2-zone "a"                                                                                 AWS zone for instance (i.e. a,b,c,d,e) [$AWS_ZONE]
#    --driver, -d "virtualbox"                                                                            Driver to create machine with. [$MACHINE_DRIVER]
#    --engine-env [--engine-env option --engine-env option]                                               Specify environment variables to set in the engine
#    --engine-insecure-registry [--engine-insecure-registry option --engine-insecure-registry option]     Specify insecure registries to allow with the created engine
#    --engine-install-url "https://get.docker.com"                                                        Custom URL to use for engine installation [$MACHINE_DOCKER_INSTALL_URL]
#    --engine-label [--engine-label option --engine-label option]                                         Specify labels for the created engine
#    --engine-opt [--engine-opt option --engine-opt option]                                               Specify arbitrary flags to include with the created engine in the form flag=value
#    --engine-registry-mirror [--engine-registry-mirror option --engine-registry-mirror option]           Specify registry mirrors to use [$ENGINE_REGISTRY_MIRROR]
#    --engine-storage-driver                                                                              Specify a storage driver to use with the engine
#    --swarm                                                                                              Configure Machine to join a Swarm cluster
#    --swarm-addr                                                                                         addr to advertise for Swarm (default: detect and use the machine IP)
#    --swarm-discovery                                                                                    Discovery service to use with Swarm
#    --swarm-experimental                                                                                 Enable Swarm experimental features
#    --swarm-host "tcp://0.0.0.0:3376"                                                                    ip/socket to listen on for Swarm master
#    --swarm-image "swarm:latest"                                                                         Specify Docker image to use for Swarm [$MACHINE_SWARM_IMAGE]
#    --swarm-join-opt [--swarm-join-opt option --swarm-join-opt option]                                   Define arbitrary flags for Swarm join
#    --swarm-master                                                                                       Configure Machine to be a Swarm master
#    --swarm-opt [--swarm-opt option --swarm-opt option]                                                  Define arbitrary flags for Swarm master
#    --swarm-strategy "spread"                                                                            Define a default scheduling strategy for Swarm
#    --tls-san [--tls-san option --tls-san option]                                                        Support extra SANs for TLS certs