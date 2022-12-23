provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {

  ami                    = "ami-0b93ce03dcbcb10f6"
  # ami id ubuntu awsLinux etc https://cloud-images.ubuntu.com/locator/ec2/
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = "c0mrade"
  tags                   = {
    Name = "terraform_instance"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo snap install docker",
      "git clone https://github.com/shairbekov-bakyt/ExpressJS-DynamoDB.git"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/Users/c0mrade/Downloads/c0mrade(1).pem") # set path to your key
    timeout     = "4m"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0",]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
    {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0",]
      self             = false
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []

    },
    {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0",]
      ipv6_cidr_blocks = []
      self             = false
      security_groups  = []
      prefix_list_ids  = []

    }
  ]

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0",]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      description      = ""
      self             = false
      security_groups  = []
      prefix_list_ids  = []
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}
