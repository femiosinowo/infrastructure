class infrastructure::ec2::sensu () {
  ec2_instance { 'sensu-server':
    ensure             => present,
    region             => 'us-east-1',
    availability_zone  => 'us-east-1d',
    image_id           => 'ami-7f418316',
    instance_type      => 't1.micro',
    subnet             => 'DevOps-Public-Subnet',
    key_name           => 'DevOps-Keys',
    security_groups    => ['sg_sensu'],
    associate_public_ip_address => true,
    private_ip_address => '10.0.0.50',
    user_data          => template('infrastructure/userdata.sh.erb'),
    require            => Ec2_securitygroup['sg_sensu'],
    tags               => {
      server_roles => 'server_sensu',
    }
  }

  ec2_securitygroup { 'sg_sensu':
    ensure      => present,
    region      => 'us-east-1',
    vpc         => 'DevOps-GCIO-VPC',
    description => 'sensu security group',
    ingress     => [
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