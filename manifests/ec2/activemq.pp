class infrastructure::ec2::activemq () {
  ec2_instance { 'activemq':
    ensure            => 'running',
    availability_zone => 'us-east-1d',
    ebs_optimized     => 'false',
    image_id          => 'ami-2051294a',
    instance_type     => 't2.micro',
    key_name          => 'DevOps-Keys',
    monitoring        => 'false',
    region            => 'us-east-1',
    security_groups   => ['ActiveMQ'],
    subnet            => 'DevOps-Public-Subnet',
  }
}