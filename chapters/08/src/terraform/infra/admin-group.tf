resource "aws_iam_group" "admin" {
  name = "${var.application_name}-${var.environment_name}-admin"
}
/*
data "aws_iam_policy_document" "admin" {
  statement {
    effect = "Allow"
    actions = [
      "eks:ListFargateProfiles",
      "eks:DescribeNodegroup",
      "eks:ListNodegroups",
      "eks:ListUpdates",
      "eks:AccessKubernetesApi",
      "eks:ListAddons",
      "eks:DescribeCluster",
      "eks:DescribeAddonVersions",
      "eks:ListClusters",
      "eks:ListIdentityProviderConfigs",
      "iam:ListRoles"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter"
    ]
    resources = ["arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/*"]
  }
}

resource "aws_iam_policy" "admin" {
  name        = "${var.application_name}-${var.environment_name}-admin"
  description = "Policy to allow specific EKS and SSM access"
  policy      = data.aws_iam_policy_document.admin.json
}

resource "aws_iam_role_policy_attachment" "console_access" {
  role       = aws_iam_role.console_access.name
  policy_arn = aws_iam_policy.admin.arn
}

resource "aws_iam_group_policy_attachment" "admin" {
  group      = aws_iam_group.admin.name
  policy_arn = aws_iam_policy.admin.arn
}
*/

resource "aws_iam_group_membership" "admin" {
  name  = "${var.application_name}-${var.environment_name}-admin"
  users = var.admin_users
  group = aws_iam_group.admin.name
}

resource "aws_iam_group_policy_attachment" "console_access" {
  group      = aws_iam_group.admin.name
  policy_arn = aws_iam_policy.console_access.arn
}

resource "aws_iam_user_policy_attachment" "console_access" {
  for_each   = { for idx, user in var.admin_users : user => user }
  user       = each.key
  policy_arn = aws_iam_policy.console_access.arn
}