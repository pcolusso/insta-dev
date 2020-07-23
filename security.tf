resource "aws_security_group" "web" {
  name        = "default-web-example"
  description = "Security group for web that allows web traffic from internet"
  #vpc_id      = "${aws_vpc.my-vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-default-vpc"
  }
}

resource "aws_security_group" "ssh" {
  name        = "default-ssh-example"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet"
  #vpc_id      = "${aws_vpc.my-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-default-vpc"
  }
}

resource "aws_security_group" "egress-tls" {
  name        = "default-egress-tls-example"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  #vpc_id      = "${aws_vpc.my-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "egress-tls-default-vpc"
  }
}

resource "aws_security_group" "ping-ICMP" {
  name        = "default-ping-example"
  description = "Default security group that allows to ping the instance"
  #vpc_id      = "${aws_vpc.my-vpc.id}"

  ingress {
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ping-ICMP-default-vpc"
  }
}