# Create the key pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "${var.name}-key-pair" 
  public_key = tls_private_key.my_key_pair.public_key_openssh

  tags = var.tags
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
  name        = "${var.name}-vectre-instance-sg"
  description = "Security group for vectre instance"
  vpc_id      = var.vpc_id

  tags = var.tags

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
  name        = "${var.name}-second-instance-sg"
  description = "Security group for the second instance"
  vpc_id      = var.vpc_id
  tags = var.tags

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

  user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              sudo yum update -y
              sudo yum install -y docker wget unzip
              sudo systemctl enable docker
              sudo systemctl start docker
              sudo usermod -aG docker ec2-user

              # Install Docker Compose
              wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
              sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
              sudo chmod -v +x /usr/local/bin/docker-compose

              # Create VECTR directory and set permissions
              sudo mkdir -p /opt/vectr
              sudo chown ec2-user:ec2-user /opt/vectr

              # Download and extract VECTR
              cd /opt/vectr
              wget https://github.com/SecurityRiskAdvisors/VECTR/releases/download/ce-9.5.2/sra-vectr-runtime-9.5.2-ce.zip 
              unzip sra-vectr-runtime-9.5.2-ce.zip
              VECTR_HOSTNAME

              # Update .env file with new JWS/JWE keys and ALB hostname
              sed -i 's/JWS_KEY=.*/JWS_KEY=VectrJWSKey123!@#/' .env
              sed -i 's/JWE_KEY=.*/JWE_KEY=VectrJWEKey456!@#/' .env
              sed -i "s/VECTR_PORT=.*/VECTR_PORT=443/" .env
              sed -i "s/VECTR_HOSTNAME=.*/VECTR_HOSTNAME=${var.sub_domain}/" .env

              # Set proper permissions for docker.sock
              sudo chmod 666 /var/run/docker.sock

              # Start VECTR using Docker Compose
              cd /opt/vectr
              sudo docker-compose -f docker-compose.yml up -d
              EOF

  tags = var.tags
}

resource "aws_instance" "second_instance" {
  ami           = "ami-0ac4dfaf1c5c0cce9"
  instance_type = "t3.medium"
  key_name      = aws_key_pair.my_key_pair.key_name
  subnet_id     = var.public_subnets[1]  
  vpc_security_group_ids = [aws_security_group.second_instance_sg.id]

  tags = var.tags
}
