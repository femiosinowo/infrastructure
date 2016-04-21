class infrastructure::vpc::dhcp_options () {
  ec2_vpc_dhcp_options { 'dhcp-devops':
    ensure              => 'present',
    domain_name         => ['gcio.cloud'],
    domain_name_servers => ['AmazonProvidedDNS', ' 8.8.8.8'],
    region              => 'us-east-1',
  }

}