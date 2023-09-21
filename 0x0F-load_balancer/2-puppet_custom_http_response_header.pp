# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Create a custom fact to retrieve the server's hostname
facts.d:
  'custom_hostname.rb':
    ensure   => present,
    content  => 'Facter.add(:custom_hostname) do setcode "hostname" end',

# Define a custom HTTP response header in Nginx configuration
file { '/etc/nginx/conf.d/custom_http_header.conf':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => "server_tokens off;\nmore_set_headers 'X-Served-By: ${custom_hostname}';",
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

