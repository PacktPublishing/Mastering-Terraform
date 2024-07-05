resource "aws_iam_group" "ecr_image_pushers" {
  name = "${var.application_name}-${var.environment_name}-ecr-image-pushers"
}

resource "aws_iam_group_policy" "ecr_image_pushers" {

  for_each = local.repositories

  name  = "${var.application_name}-${var.environment_name}-${each.key}-ecr-image-push-policy"
  group = aws_iam_group.ecr_image_pushers.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource = aws_ecr_repository.main[each.key].arn
      }
    ]
  })
}

resource "aws_iam_group_membership" "ecr_image_pushers" {
  name  = "${var.application_name}-${var.environment_name}-ecr-image-push-membership"
  users = var.ecr_image_pushers
  group = aws_iam_group.ecr_image_pushers.name
}