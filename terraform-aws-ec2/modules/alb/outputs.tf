output "secondary_lb_arn" {
  value = aws_lb.secondary_lb.arn
}

output "secondary_tg_arn" {
  value = aws_lb_target_group.secondary_tg.arn
}

