variable "region" {
  description = "The region in which the resources will be deployed"
  default     = "us-east-2"

}

variable "aws_version" {
  description = "The version of the AWS provider to use"
  default     = "~> 5.0"

}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.large"
}

variable "ami" {
  description = "The AMI to use for the EC2 instance"
  default     = "ami-0884d2865dbe9de4b"

}

variable "access_key" {
  description = "The AWS access key"
  default     = ""

}
variable "secret_key" {
  description = "The AWS secret key"
  default     = ""

}
variable "aws_key_name" {
  description = "The name of the key pair to use for the EC2 instance"
  default     = ""
  
}

variable "aws_vpc" {
  description = "This is a dedicated VPC for the Jenkins server"
  default = "10.0.0.0/16"
}