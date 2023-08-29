#!/usr/bin/env bash
# Install and configure Nginx
class nginx_server {
  package { 'nginx':
    ensure => installed,
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('nginx_server/nginx.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
}

# Define the Nginx configuration template
file { '/etc/nginx/sites-available/default':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  source => 'puppet:///modules/nginx_server/nginx.conf',
}

# Redirect for /redirect_me
nginx::resource::location { 'redirect_me':
  location => '/redirect_me',
  rewrite  => '/ http://$host/redirected permanent',
}

include nginx_server

server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location = /redirected {
        return 200 "You have been redirected!";
    }
}

