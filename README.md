# Terraform script for OpenStack resource controlling

# Keep to know
- should know the keystone url(ex. xxx:5000/v3)

# prepare to deploy
> should change "FIXME" at variables.tf

# will be constructed infrastructure like below. 
(if you use default value)

* servers
  * deploy
  * controller X 3
  * compute X 2
  * storage X 3
* network
  * internal network
  * external network
  * storage network
  * monitor network
  * deploy network
