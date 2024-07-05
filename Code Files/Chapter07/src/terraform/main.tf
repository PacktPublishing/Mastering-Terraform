/*
resource "aws_route53_zone" "main" {
  name = var.domain_name
}
*/

# setup a resource group
resource "aws_resourcegroups_group" "main" {
  name = "${var.application_name}-${var.environment_name}"

  resource_query {
    query = jsonencode(
      {
        ResourceTypeFilters = [
          "AWS::AllSupported"
        ]
        TagFilters = [
          {
            Key    = "application"
            Values = [var.application_name]
          },
          {
            Key    = "environment"
            Values = [var.environment_name]
          }
        ]
      }
    )
  }
}