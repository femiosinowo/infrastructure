class infrastructure::ec2::test () {
ec2_instance { 'test':
  ensure              => 'running',
  availability_zone   => 'us-east-1d',
 
  ebs_optimized       => 'false',
 
  image_id            => 'ami-12663b7a',
 
  instance_type       => 't2.micro',
  key_name            => 'DevOps-Keys',
  monitoring          => 'false',
 
  private_ip_address  => '10.0.0.50',
 
  region              => 'us-east-1',
  security_groups     => ['sg_sensu'],
  subnet              => 'DevOps-Public-Subnet',
    tags               => {
      server_roles => 'server_sensu',
    }
 
}
}