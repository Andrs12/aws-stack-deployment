resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support   = var.enable_dns_support
    
    tags = merge(
        var.tags,
        {
            "Name"        = "${var.project_name}-${var.environment}-vpc"
        }
    )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
        "Name"        = "${var.project_name}-${var.environment}-igw"
    }
  )
}

resource "aws_subnet" "public" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.public_subnet_cidrs[count.index]
    availability_zone       = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = merge(
        var.tags,
        {
            "Name"        = "${var.project_name}-${var.environment}-public-${count.index + 1}"
            "Type"        = "public"
        }
    )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

    tags = merge(
        var.tags,
        {
            "Name"        = "${var.project_name}-${var.environment}-private-${count.index + 1}"
            "Type"        = "private"
        }
    )
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = merge(
        var.tags,
        {
            "Name"        = "${var.project_name}-${var.environment}-public-rt"
        }
    )
}

resource "aws_route_table_association" "public" {
    count          = length(var.public_subnet_cidrs)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id  
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
        "Name"        = "${var.project_name}-${var.environment}-default-sg-locked"
    }
  )
}