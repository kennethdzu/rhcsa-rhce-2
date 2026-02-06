variable "exam_vpc_id" {}
variable "exam_subnet_id" {}

resource "aws_security_group" "sg" {
  vpc_id = var.exam_vpc_id
  name   = "rhce-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "node" {
  ami                    = "ami-00a27ff50ac40e62a"
  instance_type          = "t3.micro"
  subnet_id              = var.exam_subnet_id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = "Terra"
  tags                   = { Name = "rhce-node" }
}

output "public_ip" { value = aws_instance.node.public_ip }
