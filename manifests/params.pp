# == Class: mock::params
#
class jenkins_rpm_builder::params {
  $installdir = '/usr/libexec/jenkins-rpm-builder',
  $repo_url_prefix = 'http://yum/repo',
  $rpm_passphrase = '',
}

