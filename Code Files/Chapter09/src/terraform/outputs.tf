output "frontend_bucket_name" {
  value = aws_s3_bucket.frontend.bucket
}
output "frontend_bucket_regional_domain_name" {
  value = aws_s3_bucket.frontend.bucket_regional_domain_name
}
output "lambda_function_name" {
  value = aws_lambda_function.main.function_name
}
output "alb_endpoint" {
  value = aws_lb.main.dns_name
}
