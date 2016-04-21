class infrastructure::ec2::test () {
ec2_instance { 'test':
  ensure              => 'running',
  availability_zone   => 'us-east-1d',
  block_devices       => [{'delete_on_termination' => 'true', 'device_name' => '/dev/sda1'}],
  ebs_optimized       => 'false',
  hypervisor          => 'xen',
  image_id            => 'ami-12663b7a',
 
  instance_type       => 't2.micro',
  key_name            => 'DevOps-Keys',
  monitoring          => 'false',
  private_dns_name    => 'ip-10-0-0-59.ec2.internal',
  private_ip_address  => '10.0.0.59',
 
  region              => 'us-east-1',
  security_groups     => ['DevOps-SG-Public', 'DevOps-FreeIPA'],
  subnet              => 'DevOps-Public-Subnet',
  virtualization_type => 'hvm',
}
}