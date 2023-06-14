terraform {
  source = "../ec2"
}


include {
  path = find_in_parent_folders()
}

locals {
  env_vars = yamldecode(file(find_in_parent_folders("env.yaml")))
}

dependency "vpc" {
  config_path = find_in_parent_folders("vpc")

  mock_outputs = {
    vpc_id = "vpc-00000000"
    public_subnets = [
      "subnet-00000000",
      "subnet-00000001"
    ]
    private_subnets = [
      "subnet-00000000",
      "subnet-00000001",
      "subnet-00000002"
    ]
    azs = [
    "az1",
    "az2"]
  }
}

dependency "sg" {
  config_path = find_in_parent_folders("sg")

  mock_outputs = {
    this_security_group_id = "sg-00000000"
  }
}

dependency "ami" {
  config_path = find_in_parent_folders("ami")

  mock_outputs = {
    id = "ami-00000000000000000"
  }
}

dependency "role" {
  config_path = find_in_parent_folders("iam/role")

  mock_outputs = {
    iam_instance_profile_name = "mock_name"
  }
}

inputs = {
  name           = "webserver-${local.env_vars.env}"
  count          = 1

  ami                    = dependency.ami.outputs.id

  server_name_web        = "web-${local.env_vars.env}"
  volume_type_web        = "gp2"
  instance_type_web      = "t2.micro"
  user_data_bastion      = base64encode(file(find_in_parent_folders("files/script/user_data.sh")))

  server_name_bastion    = "bastion-${local.env_vars.env}"
  volume_type_bastion    = "gp3"
  instance_type_bastion  = "t3.micro"
  user_data_web          = base64encode(file(find_in_parent_folders("files/script/mariadb.sh")))

  vpc_security_group_ids      = [dependency.sg.outputs.this_security_group_id]
  public_subnets              = dependency.vpc.outputs.public_subnets
  private_subnets             = dependency.vpc.outputs.private_subnets
  azs                         = dependency.vpc.outputs.azs
  iam_instance_profile        = dependency.role.outputs.iam_instance_profile_name
  key_name                    = "" #"vinicius-test"
  availability_zone           = dependency.vpc.outputs.azs
  subnet_id                   = dependency.vpc.outputs.public_subnets
  associate_public_ip_address = true


  #user_data = base64encode(file("${element(local.scripts, 0)}"))
}



