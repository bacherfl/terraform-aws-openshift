//  The region we will deploy our cluster into.
variable "region" {
  description = "Region to deploy the cluster into"
<<<<<<< HEAD
  default = "eu-central-1"
=======
  default = "us-west-2"
>>>>>>> dae3d37e9c811d765ebadc64168e5f3991b97c6a
}

//  The public key to use for SSH access.
variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

<<<<<<< HEAD
variable "cluster-id" {
  default = "flo"
}
=======
// Additional Idenitification for created AWS objects - uncomment to use
variable "ocp_user" {
  default = ""
}
					
variable "ocp_user_email" {
  default = ""
}

>>>>>>> dae3d37e9c811d765ebadc64168e5f3991b97c6a
