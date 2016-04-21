class infrastructure::rds::drupal () {
  rds_instance { 'gciodrupal':
    ensure                  => 'present',
    allocated_storage       => '5',
    backup_retention_period => '0',
    db_instance_class       => 'db.t2.micro',
    db_name                 => 'gciodrupal',
    db_parameter_group      => 'default.mysql5.6',
    db_subnet               => 'drupal',
    endpoint                => 'gciodrupal.crytlcp6wpza.us-east-1.rds.amazonaws.com',
    engine                  => 'mysql',
    engine_version          => '5.6.27',
    license_model           => 'general-public-license',
    master_username         => 'gciodrupal',
    multi_az                => 'false',
    port                    => '3306',
    region                  => 'us-east-1',
    storage_type            => 'gp2',
  }
}