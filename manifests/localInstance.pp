#
# Java 
#
class { "java":
 	version	=> "latest"
}

#
# configure firewall
#
firewall { "0000 accpet all elasticsearch trafic":
    port   => [9200, 9300, 8080],
    proto  => "tcp",
    action => "accept"
}

#
#  install Es 
#
class { 'elasticsearch':
  autoupgrade => true ,
  package_url => 'https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.7.noarch.rpm',
	config => {
      'network' => {
        'publish_host' => '_eth1:ipv4_'
      },    
     	'cluster' => {
     		'name' => 'lvTwetterCluster' 
     	}
   	}
}
 
elasticsearch::plugin{'royrusso/elasticsearch-HQ':
  module_dir => "/usr/share/elasticsearch/plugin",
  require => Class["Java"]
} 