resource "time_static" "ami_update" {
  triggers = {
    # Save the time each switch of an AMI id
    ami_id = data.aws_ami.example.id
  }
}

resource "aws_instance" "server" {
  # Read the AMI id "through" the time_static resource to ensure that
  # both will change together.
  ami = time_static.ami_update.triggers.ami_id

  tags = {
    AmiUpdateTime = time_static.ami_update.rfc3339
  }

  # ... (other aws_instance arguments) ...
}

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.example_subnet.id
  tags = {
    Name = "example-instance"
    Env  = "dev"
  }
}

resource "aws_subnet" "example_subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.example_vpc.id
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "example-vpc"
  }
}
