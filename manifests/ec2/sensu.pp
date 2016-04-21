class infrastructure::ec2::sensu (
  $availability_zone         = hiera('infrastructure::ec2::availability_zone'),
  $instance_type             = hiera('infrastructure::ec2::instance_type'),
  $key_name = hiera('infrastructure::ec2::key_name'),
  $region   = hiera('infrastructure::ec2::region'),
  $subnet   = hiera('infrastructure::ec2::subnet'),
  $image_id = hiera('infrastructure::ec2::image_id'),
  $vpc      = hiera('infrastructure::ec2::vpc'),
  $iam_instance_profile_name = hiera('infrastructure::ec2::iam_instance_profile_name'),) {
  ec2_instance { 'sensu-server':
    ensure    => present,
    availability_zone         => $availability_zone,
    image_id  => $image_id,
    instance_type             => $instance_type,
    key_name  => $key_name,
    private_ip_address        => '10.0.0.50',
    user_data => template('infrastructure/userdata.sh.erb'),
    require   => Ec2_securitygroup['sg_sensu'],
    region    => $region,
    security_groups           => ['sg_sensu'],
    iam_instance_profile_name => $iam_instance_profile_name,
    subnet    => $subnet,
    tags      => {
      server_role => 'server_sensu',
    }
  }

  ec2_securitygroup { 'sg_sensu':
    ensure      => present,
    region      => $region,
    vpc         => $vpc,
    description => 'sensu security group',
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
      {
        security_group => 'sg_sensu',
      }
      ],
    tags        => {
      reason => 'ec2-sensu',
    }
    ,
  }
}