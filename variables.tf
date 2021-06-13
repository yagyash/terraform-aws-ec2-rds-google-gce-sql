variable "aws_region" {
  type = list
  default = ["ap-south-1" , "us-west-1", "eu-west-1"]
}
variable "profile" {
  default = "default"
}
variable "project" {
  default = "development-env-315408"
}
variable "credential_path" {
  default = "C:/Users/yagya/Downloads/development-env-315408-c44d25ad7c5b.json"
}
variable "gcp_region" {
  type = list
  default = ["us-central1", "asia-south1", "us-west2"]
}
variable "ec2" {
  default = "web-prod"
}
variable "instance_type" {
  type = map
  default = {
  zone1 = "t2.small"
  zone2 = "t2.micro"
  zone3 = "t2.nano"
  }
}
variable "engine" {
  type = list
  default = ["mysql", "aurora-mysql", "aurora-postgresql"]
}
variable "engine_version" {
  type = map
  default = {
       mysql = "5.7"
       aurora-mysql = "2.07.1"
       aurora-postgresql = "13.2-R1"
}
}
variable "db-prod_name" {
  default = "sqldb" 
}
variable "db-prod_user" {
  default = "yagya"
}
variable "db-prod_password" {
  default = "dbpassword"
}
variable "instance_class" {
  type = list
  default = ["db.t3.large", "db.t3.micro", "db.t3.small", "db.t3.medium"]
}
variable "compute_address" {
  default = "ipv4-address"
}
variable "firewall-rule" {
  default = "allow-http"
}
variable "gcp_network" {
  default = "default"
}
variable "gce" {
  default = "web-dev"
}
variable "machine_type" {
  type = map
  default = {
  type1 = "n1-standard-1"
  type2 = "n1-standard-2"
  type3 = "f1-micro"
  }
}
variable "gcp_zone" {
  type = list
  default = ["us-central1-a", "asia-south1-b", "us-west2-c"]
}
variable "gcp_image" {
  type = map
  default = {
  us-central1-a = "centos-cloud/centos-7"
  us-central1-b = "debian-cloud/debian-9"
  us-central1-c = "ubuntu-cloud/ubuntu-16.04-LTS"
  }
}
variable "key" {
  default = "yagyash1"
}
variable "user" {
  default = "yagya"
}
variable "publickey" {
  default = "C:/Users/yagya/yagyakey.pub"
}
variable "privatekey" {
  default = "C:/Users/yagya/yagyakey"
}
variable "acces" {
  default = "allow_access"
}
variable "db_instance_name" {
  default = "db-dev"
}
variable "database_version" {
  type = list
  default = ["POSTGRESS_11", "POSTGRESS_12", "MYSQL_5_6", "MYSQL_8_0", "MYSQL_5_7"]
}
variable "database_name" {
  default = "sqldb"
}
variable "username" {
  default = "yagya"
}
variable "db_password" {
  default = "dbpassword"
}