data "aws_vpc" "selected" {
    id = var.vpc_id
}

# locals {
#   # Hardcoding the subnet IDs and making sure they are from different AZs
#   selected_subnets = [
#     "subnet-0875e38464719da68",  # Subnet 1 in AZ 1
#     "subnet-09635b96c040136f3",  # Subnet 2 in AZ 2
#     "subnet-0e6101b428c263e09"   # Subnet 3 in AZ 3
#   ]
# }


locals {
  # Hardcoding the subnet IDs and making sure they are from different AZs
  selected_subnets = [
    "subnet-0c565285283682994",  # Subnet 1 in AZ 1
    "subnet-0ce8c4c8ea9ff5e3d",  # Subnet 2 in AZ 2
    "subnet-0fa41cfe758db78c8"   # Subnet 3 in AZ 3
  ]
}



