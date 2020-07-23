provider "aws" {
  profile = "default"
  region = "ap-southeast-2"
  access_key = file(var.aws_access_key)
  secret_key = file(var.aws_secret_key)
}

resource "aws_key_pair" "key" {
  key_name   = "dev-login"
  public_key = file(var.public_key)
}

resource "aws_instance" "development" {
  ami = "ami-08a648fb5cc86fb74"
  instance_type = "t2.micro"
  key_name   = "dev-login"

  # Allow network connections
  vpc_security_group_ids = [
    "${aws_security_group.web.id}",
    "${aws_security_group.ssh.id}",
    "${aws_security_group.egress-tls.id}",
    "${aws_security_group.ping-ICMP.id}"
  ]

  # Define volume
  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 30
    delete_on_termination = true
  }

  # Define connection
  connection {
    host = self.public_ip
    private_key = "${file(var.private_key)}"
    user        = "${var.username}"
  }

  # Copy local env
  provisioner "file" {
    source = "env"
    destination = "~"
  }

  # Install python for ansible
  provisioner "remote-exec" {
    inline = ["sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install python3 -y"]
  }

  # Install from the development playbook
  provisioner "local-exec" {
    command = <<EOT
      echo "[dev-vm]" | tee -a dev.ini;
      echo "${aws_instance.development.public_ip} ansible_user=${var.username} ansible_ssh_private_key_file=${var.private_key} ansible_python_interpreter=python3" | tee -a dev.ini
      echo "${aws_instance.development.public_ip}" | tee -a address.txt
      export ANSIBLE_HOST_KEY_CHECKING=false;
      ansible-galaxy install -r requirements.yml
      ansible-playbook -u ${var.username} --private-key ${var.private_key} -i dev.ini development.yml;
    EOT
  }
}