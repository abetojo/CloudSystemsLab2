// ec2/main.tf

provider "aws" {
  region = "us-east-1"
}

variable "subnet_ids" {
  type = list(string)
}

resource "aws_instance" "web" {
  count         = length(var.subnet_ids)
  ami           = "ami-0d7a109bf30624c99" 
  instance_type = "t2.micro"
  subnet_id     = var.subnet_ids[count.index]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              service docker start
              docker run -d -p 80:80 nginx
              docker run -d -p 8080:80 nginx
              docker run -d -p 8081:80 nginx
              EOF
}

output "instance_ids" {
  value = aws_instance.web[*].id
}