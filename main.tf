resource "aws_instance" "minikube01_ins" {
    ami = var.ami_id
    instance_type = var.ins_type
    tags = var.tags_argo_minikube
    key_name = aws_key_pair.minikube01_ins_key.key_name
    vpc_security_group_ids = [aws_security_group.minikube01_secgrp.id]

    root_block_device {
        volume_size = var.minikube01_disksize
        volume_type = var.minikube01_disktype
        encrypted = true
    }
}
resource "aws_key_pair" "minikube01_ins_key" {
    key_name = var.minikube01_key_name
    public_key = var.minikube01_pubkey_val
    tags = var.tags_argo_minikube
}

resource "aws_security_group" "minikube01_secgrp" {
  name = var.minikube01_secgrp_name
  description = "Security group for minikube instance"
  tags        = var.tags_argo_minikube
}

resource "aws_security_group_rule" "minikube_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.minikube01_secgrp.id
  description       = "Allow SSH access"
}

resource "aws_security_group_rule" "minikube_ingress_argo" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.minikube01_secgrp.id
  description       = "Allow Argo access"
}
resource "aws_security_group_rule" "minikube_icmp_ingress" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.minikube01_secgrp.id
  description       = "Allow ICMP access"
}

resource "aws_security_group_rule" "minikube_egress_http" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.minikube01_secgrp.id
  description       = "Allow HTTP access to anywhere"
}

resource "aws_security_group_rule" "minikube_egress_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.minikube01_secgrp.id
  description       = "Allow HTTPS access to anywhere"
}


# Output block for public IP
output "instance_public_ip" {
    description = "Public IP of the EC2 instance"
    value       = aws_instance.minikube01_ins.public_ip
}
# Output block for instance ID
output "instance_id" {
    description = "Instance ID of the EC2 instance"
    value       = aws_instance.minikube01_ins.id
}
# Output block for instance state
output "instance_state" {
    description = "State of the EC2 instance"
    value       = aws_instance.minikube01_ins.instance_state
}