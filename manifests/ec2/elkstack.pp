class infrastructure::ec2::elkstack () {
  infrastructure::ec2::template { 'elkstack':
    hostname                   => 'elkstack.gcio.cloud',
    ensure_value               => 'present',
    server_role                => 'server_elkstack',
    ip_addr                    => '10.0.0.52',
    security_group_name               => "sg_elkstack",
    security_group_description => "Elkstack Security groups",
    $instance_type              => 't2.small',
    security_group_ingress     => [
      {
        protocol => 'tcp',
        port     => '22',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '80',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '9200',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '5044',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '5601',
        cidr     => '0.0.0.0/0',
      }
 ,
      {
        'cidr'      => '0.0.0.0/0',
        'from_port' => '-1',
        'protocol'  => 'icmp',
        'to_port'   => '-1'
      }
      ],
  }

}
