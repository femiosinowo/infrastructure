class infrastructure::route53::dnsrecord () {
  route53_zone { 'gcio.cloud.': ensure => 'present', }

  route53_a_record { 'sensu.gcio.cloud.':
    ensure => 'present',
    ttl    => '300',
    values => ['10.0.0.50'],
    zone   => 'gcio.cloud.',
  }

  route53_a_record { 'tomcat.gcio.cloud.':
    ensure => 'present',
    ttl    => '300',
    values => ['10.0.0.51'],
    zone   => 'gcio.cloud.',
  }

}