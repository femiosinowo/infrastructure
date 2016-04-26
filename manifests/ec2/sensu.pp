class infrastructure::ec2::tomcat (
  $hostname = 'sensu.gcio.cloud',
  $hostnameR53               = "${hostname}.",
  # don't forget it must always end with a dot.
  $ensure_value              = 'present',
  $server_role               = 'server_sensu',
  $ip_addr  = '10.0.0.50',
  $security_group_name       = $hostname,
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
    exec { "puppet cert clean ${hostname}":
      cwd     => "/var/tmp",
      path    => ["/usr/bin"],
      require => Ec2_instance['deleteEC2'],
    }

    route53_a_record { "${hostname}.": ensure => $ensure_value, }

    ec2_instance { 'deleteEC2':
      name   => $hostname,
      ensure => absent,
    }

    ec2_securitygroup { $security_group_name:
      ensure  => $ensure_value,
      require => Ec2_instance['deleteEC2'],
    }

  } else {
    route53_a_record { "${hostname}.":
      ensure => $ensure_value,
      ttl    => '300',
      values => [$ip_addr],
      zone   => 'gcio.cloud.',
    }

    ec2_instance { $hostname:
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
        server_role => $server_role,
      }
    }

    ec2_securitygroup { $security_group_name:
      ensure      => $ensure_value,
      region      => $region,
      vpc         => $vpc,
      description => $security_group_name,
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
        ],
    #      tags        => {
    #        reason => $security_group_name,
    #      }
    #      ,
    }
  }
}