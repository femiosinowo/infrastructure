class infrastructure::ec2::tomcat (
  $hostname = 'tomcat.gcio.cloud.',
  # don't forget it must always end with a dot.
  $ensure_value              = 'absent',
  $server_role               = 'server_tomcat',
  $ip_addr  = '10.0.0.51',
  $security_group_name       = "sg_tomcat",
  $availability_zone         = hiera('infrastructure::ec2::availability_zone'),
  $instance_type             = hiera('infrastructure::ec2::instance_type'),
  $key_name = hiera('infrastructure::ec2::key_name'),
  $region   = hiera('infrastructure::ec2::region'),
  $subnet   = hiera('infrastructure::ec2::subnet'),
  $image_id = hiera('infrastructure::ec2::image_id'),
  $vpc      = hiera('infrastructure::ec2::vpc'),
  $iam_instance_profile_name = hiera('infrastructure::ec2::iam_instance_profile_name'),) {
  #
  if $ensure_value == 'absent' {
    exec { "puppet cert clean ip-10-0-0-51.gcio.cloud":
      cwd  => "/var/tmp",
      path => ["/usr/bin"]
    }

    route53_a_record { $hostname: ensure => $ensure_value, }

    ec2_instance { $server_role: ensure => $ensure_value, }

  } else {
    route53_a_record { $hostname:
      ensure => $ensure_value,
      ttl    => '300',
      values => [$ip_addr],
      zone   => 'gcio.cloud.',
    }

    ec2_instance { $server_role:
      ensure    => $ensure_value,
      availability_zone         => $availability_zone,
      image_id  => $image_id,
      instance_type             => $instance_type,
      key_name  => $key_name,
      private_ip_address        => $ip_addr,
      user_data => template('infrastructure/userdata.sh.erb'),
      require   => Ec2_securitygroup[$security_group_name],
      region    => $region,
      security_groups           => [$security_group_name],
      iam_instance_profile_name => $iam_instance_profile_name,
      subnet    => $subnet,
      tags      => {
        server_role => 'server_tomcat',
      }
    }

    #  fact { 'server_role':
    #    content => 'server_sensu',
    #    ensure  => present,
    #  }

    ec2_securitygroup { $security_group_name:
      ensure      => $ensure_value,
      region      => $region,
      vpc         => $vpc,
      description => 'Tomcat Security group',
      # require     => Ec2_instance[$server_role],
      ingress     => [
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
      tags        => {
        reason => $security_group_name,
      }
      ,
    }
  }
}