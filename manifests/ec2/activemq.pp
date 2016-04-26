class infrastructure::ec2::activemq () {
  infrastructure::ec2::template { 'activemq':
    hostname                   => 'activemq.gcio.cloud',
    ensure_value               => 'present',
    server_role                => 'server_activemq',
    ip_addr                    => '10.0.0.65',
    security_group_name        => "sg_activemq",
    security_group_description => "activemq Security groups",
    security_group_ingress     => [
      {
        protocol => 'tcp',
        port     => '22',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '61613',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '61614',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '8161',
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
