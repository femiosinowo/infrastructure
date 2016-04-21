class infrastructure::vpc::subnet::allsubnets () {
  ec2_vpc_subnet { 'DevOps-Private-Subnet':
    ensure                  => 'present',
    availability_zone       => 'us-east-1a',
    cidr_block              => '10.0.1.0/24',
    map_public_ip_on_launch => 'false',
    region                  => 'us-east-1',
    vpc                     => 'DevOps-GCIO-VPC',
  }

  ec2_vpc_subnet { 'DevOps-Public-Subnet':
    ensure                  => 'present',
    availability_zone       => 'us-east-1d',
    cidr_block              => '10.0.0.0/24',
    map_public_ip_on_launch => 'true',
    region                  => 'us-east-1',
    vpc                     => 'DevOps-GCIO-VPC',
  }
 
}