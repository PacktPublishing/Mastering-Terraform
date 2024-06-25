
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name        = "${var.application_name}-${var.environment_name}-network"
    application = var.application_name
    environment = var.environment_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  depends_on = [aws_vpc.main]
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.available.names
  result_count = var.az_count
}

locals {
  # subnet maps...try target with shuffle...destroy
  azs_random = random_shuffle.az.result
  azs_slice  = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  public_subnets = { for k, v in local.azs_random :
    k => {
      cidr_block        = cidrsubnet(var.vpc_cidr_block, 3, k)
      availability_zone = v
    }
  }
  private_subnets = { for k, v in local.azs_random :
    k => {
      cidr_block        = cidrsubnet(var.vpc_cidr_block, 3, k + var.az_count)
      availability_zone = v
    }
  }
}
