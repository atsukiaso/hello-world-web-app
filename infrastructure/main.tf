provider "aws" {
  region = "eu-west-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "instance" {
  ami           = "ami-06fd78dc2f0b69910"
  vpc_security_group_ids = [aws_security_group.http_sg.id]

  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"

  user_data     = "${file("setup_instance.sh")}"
  instance_type = "t2.micro"
  depends_on = [
    aws_s3_bucket_object.object1
  ]
}

# ---------------- Security

resource "aws_security_group" "http_sg" {
  name = "http_sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
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

# -------------- Roles

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = "${aws_iam_role.test_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${aws_iam_role.test_role.name}"
}


resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

# -------------- Bucket 

resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_object" "object1" {
  for_each = fileset("docker_images/", "*")
  bucket = aws_s3_bucket.b.id
  key = each.value
  source = "docker_images/${each.value}"
  etag = filemd5("docker_images/${each.value}")
}