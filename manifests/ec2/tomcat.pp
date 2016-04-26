class infrastructure::ec2::tomcat () {
  infrastructure::ec2::template { 'tomcat':
    hostname                   => 'tomcat.gcio.cloud',
    ensure_value               => 'absent',
    server_role                => 'server_tomcat',
    ip_addr                    => '10.0.0.51',
    security_group_name        => "sg_tomcat",
    security_group_description => "Tomcat Security groups",
    security_group_ingress     => [
      {
        protocol => 'tcp',
        port     => '22',
        cidr     => '0.0.0.0/0',
      }
      ,
      {
        protocol => 'tcp',
        port     => '8080',
        cidr     => '0.0.0.0/0',
      }

      ],
  }

}
