define infrastructure::ec2::template (
  $hostname = '',
  $ensure_value               = '',
  $server_role                = '',
  $ip_addr  = '',
  $security_group_name        = "",
  $availability_zone          = hiera('infrastructure::ec2::availability_zone'),
  $instance_type              = hiera('infrastructure::ec2::instance_type'),
  $key_name = hiera('infrastructure::ec2::key_name'),
  $region   = hiera('infrastructure::ec2::region'),
  $subnet   = hiera('infrastructure::ec2::subnet'),
  $image_id = hiera('infrastructure::ec2::image_id'),
  $vpc      = hiera('infrastructure::ec2::vpc'),
  $iam_instance_profile_name  = hiera('infrastructure::ec2::iam_instance_profile_name'),
  $security_group_description = 'Description for Security group',
  $security_group_ingress     = '',

  # end of variables
  ) {
  #
  if $ensure_value == 'absent' {
    exec { "puppet cert clean ${hostname}":
      cwd     => "/var/tmp",
      path    => ["/usr/bin"],
      require => Ec2_instance[$hostname],
    }

    ec2_securitygroup { 'deletingMe':
      name    => $security_group_name,
      ensure  => $ensure_value,
      require => Ec2_instance[$hostname],
    }
  }

  # else {
  # creating dns record here
  route53_a_record { "${hostname}.":
    ensure => $ensure_value,
    ttl    => '300',
    values => [$ip_addr],
    zone   => 'gcio.cloud.',
  }

  # creating ec2 innstance here
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

  # creating security groups here
  ec2_securitygroup { $security_group_name:
    # ensure      => $ensure_value,
    region      => $region,
    vpc         => $vpc,
    description => $security_group_description,
    ingress     => $security_group_ingress,
  # require     => Ec2_instance[$hostname],

  #      tags        => {
  #        reason => $security_group_name,
  #      }
  #      ,
  }

  #}
}