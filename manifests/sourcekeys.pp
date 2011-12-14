# install apt keys to verify package content as authentic
class php5-fpm::sourcekeys {
    if !defined(File["/usr/share/apt-keys"]) {
        file { "/usr/share/apt-keys":
            ensure => "directory",
            owner => "root",
            group => "root",
            mode => 0751,
        }
    }

    file { "/usr/share/apt-keys/brianmercer-php-lucid.key":
        source => "puppet:///php5-fpm/brianmercer-php-lucid.key",
        owner => "root",
        group => "root",
        mode => 0644,
        require => File["/usr/share/apt-keys"]
    }

    exec { "install-phpkey": 
        cwd => "/usr/share/apt-keys",
        path => "/usr/bin",
        command => "apt-key add brianmercer-php-lucid.key",
        logoutput => false,
        refreshonly => true,
        subscribe => File["/usr/share/apt-keys/brianmercer-php-lucid.key"],
    }
}
