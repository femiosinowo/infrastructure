class infrastructure::ec2::elkstack () {
  ec2_instance { 'elk-stack-devOps':
    ensure             => 'running',
    availability_zone  => 'us-east-1d',
    ebs_optimized      => 'false',
    image_id           => 'ami-12663b7a',
    instance_type      => 't2.small',
    key_name           => 'DevOps-Keys',
    monitoring         => 'false',
    private_ip_address => '10.0.0.120',
    region             => 'us-east-1',
    security_groups    => ['DevOps-SG-Public'],
    subnet             => 'DevOps-Public-Subnet',
    tags               => {
      server_role => 'elkstack',
    }
  }

}