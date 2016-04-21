class infrastructure::vpc::allvpcs () {
  ec2_vpc { 'DevOps-GCIO-VPC':
    ensure           => 'present',
    cidr_block       => '10.0.0.0/16',
    dhcp_options     => 'dhcp-devops',
    instance_tenancy => 'default',
    region           => 'us-east-1',
  }

  ec2_vpc { 'drupal':
    ensure           => 'present',
    cidr_block       => '10.0.0.0/16',
    dhcp_options     => 'Default Amazon',
    instance_tenancy => 'default',
    region           => 'us-east-1',
  }
}