#! /bin/sh

if [ ! -f id_rsa ]; then
	curl -o id_rsa https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant
fi

ct -pretty -in-file ignition.yml -out-file ignition.json

packer build -var-file vars-alpha.json coreos.json
