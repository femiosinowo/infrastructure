class infrastructure::ec2::elkstack (
  $ip_addr  = '10.0.0.53',
  $server_role               = 'server_elkstack',
  $security_group_name       = "sg_elkstack",
  $availability_zone         = hiera('infrastructure::ec2::availability_zone'),
  $instance_type             ='t2.small', # hiera('infrastructure::ec2::instance_type'),
  $key_name = hiera('infrastructure::ec2::key_name'),
  $region   = hiera('infrastructure::ec2::region'),
  $subnet   = hiera('infrastructure::ec2::subnet'),
  $image_id = hiera('infrastructure::ec2::image_id'),
  $vpc      = hiera('infrastructure::ec2::vpc'),
  $iam_instance_profile_name = hiera('infrastructure::ec2::iam_instance_profile_name'),) {
  ec2_instance {  $server_role:
    ensure    => present,
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

  #  fact { 'server_role':
  #    content => 'server_sensu',
  #    ensure  => present,
  #  }

  ec2_securitygroup { $security_group_name:
    ensure      => present,
    region      => $region,
    vpc         => $vpc,
    description => 'Elkstack Security group',
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