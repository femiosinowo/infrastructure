class infrastructure::ec2::elkstack () {
ec2_instance { 'elk-stack-devOps':
  ensure              => 'running',
  availability_zone   => 'us-east-1d',
  block_devices       => [{'delete_on_termination' => 'true', 'device_name' => '/dev/sda1'}],
  ebs_optimized       => 'false',
  hypervisor          => 'xen',
  image_id            => 'ami-12663b7a',
  instance_id         => 'i-60107cd6',
  instance_type       => 't2.small',
  key_name            => 'DevOps-Keys',
  monitoring          => 'false',
  private_dns_name    => 'ip-10-0-0-120.ec2.internal',
  private_ip_address  => '10.0.0.120',
  public_dns_name     => 'ec2-54-175-67-66.compute-1.amazonaws.com',
  public_ip_address   => '54.175.67.66',
  region              => 'us-east-1',
  security_groups     => ['DevOps-SG-Public'],
  subnet              => 'DevOps-Public-Subnet',
  virtualization_type => 'hvm',
}
}
}