#!/usr/bin/pup
# Installs a specific version of flask which is (2.1.0) 
package ('flask':
	ensure 	 => '2.1.0',
	provider => 'pip'
)

