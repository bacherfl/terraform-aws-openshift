# Setup our providers so that we have deterministic dependecy resolution. 
provider "aws" {
  region  = "${var.region}"
  version = "~> 2.19"
}

provider "local" {
  version = "~> 1.3"
}

provider "template" {
  version = "~> 2.1"
}

//  Create the OpenShift cluster using our module.
module "openshift" {
  source          = "./modules/openshift"
  region          = "${var.region}"
<<<<<<< HEAD
  amisize         = "t2.xlarge"    //  Smallest that meets the min specs for OS
  vpc_cidr        = "10.0.0.0/16"
  subnet_cidr     = "10.0.1.0/24"
  key_name        = "openshift-${var.cluster-id}"
  public_key_path = "${var.public_key_path}"
  cluster_name    = "openshift-cluster-flo"
  cluster_id      = "openshift-cluster-${var.region}-${var.cluster-id}"
=======
  amisize         = "t3.xlarge"    //  Smallest that meets the min specs for OS is t2.large
  vpc_cidr        = "10.0.0.0/16"
  subnet_cidr     = "10.0.1.0/24"
  key_name        = "ocp-workshop-${var.ocp_user}"
  public_key_path = "${var.public_key_path}"
  cluster_name    = "openshift-cluster-${var.ocp_user}"
  cluster_id      = "openshift-cluster-${var.region}"
>>>>>>> dae3d37e9c811d765ebadc64168e5f3991b97c6a
}

//  Output some useful variables for quick SSH access etc.
output "master-url" {
  value = "https://${module.openshift.master-public_ip}.xip.io:8443"
}
output "master-public_ip" {
  value = "${module.openshift.master-public_ip}"
}
output "bastion-public_ip" {
  value = "${module.openshift.bastion-public_ip}"
}
