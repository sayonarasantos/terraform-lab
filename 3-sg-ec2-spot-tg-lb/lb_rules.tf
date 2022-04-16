resource "aws_lb_listener_rule" "backend_lb_rule" {
  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api*"]
    }
  }

  condition {
    host_header {
      values = ["ladygaga.*"]
    }
  }

  depends_on = [
    aws_lb_target_group_attachment.backend_tga
  ]
}

resource "aws_lb_listener_rule" "frontend_lb_rule" {
  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }

  condition {
    host_header {
      values = ["bornthisway.*"]
    }
  }

  depends_on = [
    aws_lb_target_group_attachment.frontend_tga
  ]
}
