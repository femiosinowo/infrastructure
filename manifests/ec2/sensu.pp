class infrastructure::ec2::sensu () {
  infrastructure::ec2::template { 'sensu':
    hostname                   => 'sensu.gcio.cloud',
    ensure_value               => 'present',
    server_role                => 'server_sensu',
    ip_addr                    => '10.0.0.50',
    security_group_name        => "sg_sensu",
    security_group_description => "Sensu Security groups",
    security_group_ingress     => [
      {
        protocol => 'tcp',
        port     => '22',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '3000',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '4567',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '5672',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '8080',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '15671',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '4242',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '15672',
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
