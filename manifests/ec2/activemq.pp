class infrastructure::ec2::activemq () {
ec2_instance { 'activemq':
  ensure              => 'stopped',
  availability_zone   => 'us-east-1d',
  block_devices       => [{'delete_on_termination' => 'true', 'device_name' => '/dev/sda1'}],
  ebs_optimized       => 'false',
  hypervisor          => 'xen',
  image_id            => 'ami-2051294a',
  instance_id         => 'i-aa4b6d2f',
  instance_type       => 't2.micro',
  key_name            => 'DevOps-Keys',
  monitoring          => 'false',
  region              => 'us-east-1',
  security_groups     => ['ActiveMQ'],
  subnet              => 'DevOps-Public-Subnet',
  virtualization_type => 'hvm',
}
}