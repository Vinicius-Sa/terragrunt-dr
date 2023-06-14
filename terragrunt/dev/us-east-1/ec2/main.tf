locals {

  instance_configurations = {
    web = {

      name              = var.server_name_web

      instance_type     = var.instance_type_web
      volume_type       = var.volume_type_web
      throughput        = var.throughput
      volume_size       = var.volume_size

      user_data_base64  = var.user_data_web

      availability_zone = element(var.azs, 0)
      subnet_id         = element(var.public_subnets, 0)
      root_block_device = [
        {
          encrypted     = true
          volume_type   = var.volume_type_web
          throughput    = var.throughput
          volume_size   = var.volume_size
          tags = {
            Name        = "web-root-block"
          }
        }
      ]
    },
    bastion = {

      name              = var.server_name_bastion

      instance_type     = var.instance_type_bastion
      volume_type       = var.volume_type_bastion
      volume_size       = var.volume_size

      user_data_base64  = var.user_data_bastion

      availability_zone = element(var.azs, 1)
      subnet_id         = element(var.public_subnets, 1)
      root_block_device = [
        {
          encrypted     = false
          volume_type   = var.volume_type_bastion
          throughput    = var.throughput
          volume_size   = var.volume_size
          tags = {
            Name        = "bastion-root-block"
          }
        }
      ]
    }
  }
}

module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  for_each                    = local.instance_configurations

  name                        = each.value.name

  user_data_base64            = each.value.user_data_base64

  instance_type               = each.value.instance_type
  availability_zone           = each.value.availability_zone
  subnet_id                   = each.value.subnet_id

  key_name                    = var.key_name

  associate_public_ip_address = true
}