provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""

}

resource "aws_instance" "example" {

  ami                    = "ami-0b93ce03dcbcb10f6" # ami id ubuntu awsLinux etc https://cloud-images.ubuntu.com/locator/ec2/
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = "${aws_key_pair.deployer.key_name}"
  tags                   = {
    Name = "terraform_instance"
  }
  provisioner "remote-exec" {
    inline = [
      "touch hello.txt", # touch hello.txt in your instance also you can git clone or something that
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("") # set path to your key
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
    }
  ]
}

# first generate rsa key
# ssh-keygen -t rsa -b 2048
resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "" # set content of  your public rsa key
}
