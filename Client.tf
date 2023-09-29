# Define the AWS provider configuration
provider "aws" {
  region = "eu-north-1a" # Specify your desired AWS region
}

# Create a security group for the client
resource "aws_security_group" "client_security_group" {
  name        = "clientSecurityGroup"
  description = "Security group for the client"
  
  # Define inbound rules to allow necessary ports (e.g., for application communication)
  ingress {
    from_port   = 80 # Adjust as needed
    to_port     = 80 # Adjust as needed
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # This should be restricted to trusted IPs in a production environment
  }
  
  # Add more ingress rules as needed
}

# Create an EC2 instance for the client
resource "aws_instance" "client_instance" {
  ami           = "ami-086ee6e5ed2ea3434" # Replace with the appropriate AMI ID
  instance_type = "t3.micro"     # Adjust as needed
  
  # Attach the security group created earlier
  security_groups = [aws_security_group.client_security_group.name]
  
  # Define the subnet where the client instance should be launched
  subnet_id = "subnet-021c97d06bbb8ab5b" # Replace with the correct subnet ID
  
  # You can add more configuration settings like key_name, user_data, etc., here
}
