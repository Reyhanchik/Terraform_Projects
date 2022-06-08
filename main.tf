resource "aws_key_pair" "projectkey" {
  key_name   = "project-demo"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCPLQaupjQH8kWPBDtdmbtMYJiLNRh/aGCFpjnyaUF6jOvgst9AV6q6+ZEy9Tu0ERIQKR3pSdB7Ak1x1tb/zd83l8fB/PTpGaRWzTIqJbYjvVNzUFPCW/6hh5siuk5lt5GpKQ70ZItVsbt5qd/idZ7UXx7CWM2kGe978GFJcTU66J8NEttJbUXkW/wCyHDZfYHKynPO0A0xzO3la6WBR4U0/YTz6/Q0SGVmse63TyvOEqG8N3Sc9yRsnj8KoSu6iYLiPuCvQTtSbNNwjU5Akzpoor6i48Lo7jwQp0deSDmKSsutj1q8ORlL7JUMHyZdEhX1y4ntbbozHkDr9KWYtfn9"
}

resource "aws_instance" "projectfinal" {
  ami           = var.AMI
  for_each      = var.INSTANCE_TYPE
  instance_type = each.value
  key_name      = "project-demo"

  # tags = {
  #   Name = var.INSTANCE_NAME[count.index]
  # }

}

resource "aws_instance" "Ansible" {
  ami           = var.AMI
  instance_type = "t2.small"
  key_name      = "project-demo"

  user_data = "${file("ansible-script.sh")}"

  tags = {
    Name = "Ansible_server"
  }
}

resource "github_repository" "final_project" {
  name = "final_project"
  description = "For TCH project"

  visibility = "public" 
  allow_merge_commit = true 
  auto_init          = true
}



resource "aws_vpc" "vpcproject" {
  cidr_block = "${var.VPC_CIDR_BLOCK}"
  instance_tenancy = "default"
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "vpcfinalproject"
  }
}

resource "aws_subnet" "subnetproject" {
  vpc_id     = aws_vpc.vpcproject.id
  cidr_block = "${var.SUBNET_CIDR_BLOCK}"

  tags = {
    Name = "subnetfinalproject"
  }
}

resource "aws_security_group" "sgroup" {
  name        = "sgroup"
  description = "Allow 22 and 8080 inbound traffic"
  vpc_id      = aws_vpc.vpcproject.id

  ingress {
    description      = "Ingress1 from VPC"
    from_port        = "${var.INGRESS1}"
    to_port          = "${var.INGRESS1}"
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpcproject.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.vpcproject.ipv6_cidr_block]
  }

  ingress {
    description      = "Ingress2 from VPC"
    from_port        = "${var.INGRESS2}"
    to_port          = "${var.INGRESS2}"
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpcproject.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.vpcproject.ipv6_cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allowtraffic"
  }
}

resource "aws_route_table" "rtproject" {
  vpc_id = aws_vpc.vpcproject.id

  route {
    cidr_block = "${var.RT_CIDR_BLOCK}"
    gateway_id = aws_internet_gateway.igwproject.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.egressigw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_internet_gateway"  "igwproject" {
  vpc_id = aws_vpc.vpcproject.id

  tags = {
    Name = "igwproject"
  }
}

resource "aws_egress_only_internet_gateway" "egressigw" {
  vpc_id = aws_vpc.vpcproject.id

  tags = {
    Name = "egressigw"
  }
}