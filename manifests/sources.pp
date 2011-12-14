# install the apt sources 
class php5-fpm::sources {
    $require = Class["php5-fpm::sourcekeys"]

    file { "/etc/apt/sources.list.d/brianmercer-php-lucid.list":
        source => "puppet:///mysql/brianmercer-php-lucid.list",
        owner => "root",
        group => "root",
        mode => 0644,
    }

    exec { "install-php5-fpm": 
        path => "/usr/bin",
        command => "apt-get update -y",
        logoutput => false,
        refreshonly => true,
        subscribe => File["/etc/apt/sources.list.d/brianmercer-php-lucid.list"],
        require => $require,
    }
}
