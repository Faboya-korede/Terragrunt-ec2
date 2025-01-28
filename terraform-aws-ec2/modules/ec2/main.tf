# Create the key pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "key-pair" 
  public_key = tls_private_key.my_key_pair.public_key_openssh
}

# Generate the private key locally
resource "tls_private_key" "my_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key to your local machine
resource "local_file" "private_key" {
  filename = "${path.module}/my-key-pair.pem" 
  content  = tls_private_key.my_key_pair.private_key_pem
  file_permission = "0600" 
}



resource "aws_security_group" "vectre_instance_sg" {
  name        = "vectre-instance-sg"
  description = "Security group for vectre instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
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

resource "aws_security_group" "second_instance_sg" {
  name        = "second-instance-sg"
  description = "Security group for the second instance"
  vpc_id      = var.vpc_id

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

resource "aws_instance" "vectre_instance" {
  ami           = "ami-0ac4dfaf1c5c0cce9"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.my_key_pair.key_name
  subnet_id     = var.public_subnets[2]  
  vpc_security_group_ids = [aws_security_group.vectre_instance_sg.id]

  tags = {
    Name = "vectre-instance"
  }
}

resource "aws_instance" "second_instance" {
  ami           = "ami-0ac4dfaf1c5c0cce9"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.my_key_pair.key_name
  subnet_id     = var.public_subnets[1]  
  vpc_security_group_ids = [aws_security_group.second_instance_sg.id]

  tags = {
    Name = "second-instance"
  }
}
