class jenkins_rpm_builder (
  installdir      = $jenkins_rpm_builder::params::installdir,
  repo_url_prefix = $jenkins_rpm_builder::params::repo_url_prefix,
  rpm_passphrase  = $jenkins_rpm_builder::params::rpm_passphrase,
) inherits jenkins_rpm_builder::params {

  validate_absolute_path($installdir)

  File {
    owner => 'root',
    group => 'root',
  }

  file { $installdir: 
    ensure => directory,
  }

  file { "$installdir/jenkins-matrix-rpm-build-collector.sh": 
    source => 'puppet:///modules/jenkins_rpm_builder/jenkins-matrix-rpm-build-collector.sh',
  }

  file { "$installdir/jenkins-rpm-builder.sh":
    source => 'puppet:///modules/jenkins_rpm_builder/jenkins-rpm-builder.sh',
  }

  file { "$installdir/rpm-sign.exp":
    content => template('jenkins_rpm_builder/rpm-sign.exp.erb'),
  }

  file { "$installdir/update-repo-aliases.sh":
    source => 'puppet:///modules/jenkins_rpm_builder/update-repo-aliases.sh',
  }

  file { '/etc/jenkins-rpm-builder.conf':
    content => template('jenkins_rpm_builder/jenkins-rpm-builder.conf.erb'),
  }

  file { "$installdir/jenkins-rpm-builder.conf":
    ensure => link,
    target => '/etc/jenkins-rpm-builder.conf',
    require => File['/etc/jenkins-rpm-builder.conf'],
  }
}
