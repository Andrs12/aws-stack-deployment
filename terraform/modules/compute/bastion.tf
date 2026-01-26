# Bastion hots
resource "aws_instance" "bastion" {
    count = var.enable_bastion ? 1 : 0

    ami = data.aws_ami.amazon_linux_2023.id
    instance_type = "t3.micro"
    subnet_id = var.public_subnet_ids[0]
    
    vpc_security_group_ids = [aws_security_group.bastion.id]
    key_name = var.key_name

    metadata_options {
      http_endpoint = "enabled"
      http_tokens =  "required"
      http_put_response_hop_limit = 1
    }

    root_block_device {
      volume_type = "gp3"
      volume_size = 8
      encrypted = true
      delete_on_termination = true
    }

    tags = merge(
      var.tags,
      {
        Name = "${var.project_name}-${var.environment}-bastion"
      }
    )
}

# Elastic IP for Bastion
resource "aws_eip" "bastion" {
  count = var.enable_bastion ? 1 : 0

    instance = aws_instance.bastion[0].id
    domain = "vpc"

    tags = merge(
      var.tags,
      {
        Name = "${var.project_name}-${var.environment}-bastion-eip"
      }
    )

    depends_on = [ aws_instance.bastion ]
}