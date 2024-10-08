resource "aws_launch_template" "web" {
  name_prefix   = "web-template-"
  image_id      = "ami-123456" # Replace with the latest Amazon Linux AMI ID
  instance_type = "t3.micro"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.public_1a.id
    security_groups             = [aws_security_group.web_sg.id]
  }

  tags = {
    Name = "web-server"
  }
}

resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  min_size            = 2
  max_size            = 5
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]

  tags = [{
    key                 = "Name"
    value               = "web-server"
    propagate_at_launch = true
  }]
}
