resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  vpc_id      = var.vpc_id
  description = "Allow HTTP and SSH"
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
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
    }
}

resource "aws_alb" "web_alb" {
  name               = "web-alb"
  internal           = false
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = var.public_subnets
}

resource "aws_alb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

resource "aws_alb_listener" "web_listener" {
  load_balancer_arn = aws_alb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.web_tg.arn
  }
}

resource "aws_instance" "web" {
  count         = length(var.public_subnets)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.public_subnets, count.index)
  security_groups = [aws_security_group.web_sg.id]
  key_name = var.key_name
  user_data = filebase64("userdata.sh")

  tags = { Name = "web-${count.index}" }
}

resource "aws_alb_target_group_attachment" "web_attach" {
  count            = length(aws_instance.web)
  target_group_arn = aws_alb_target_group.web_tg.arn
  target_id        = element(aws_instance.web.*.id, count.index)
  port             = 80
}

output "alb_dns" {
  value = aws_alb.web_alb.dns_name
}

output "web_sg_id" {
  value = aws_security_group.web_sg.id
}
