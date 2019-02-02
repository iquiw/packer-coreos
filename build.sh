#! /bin/sh

set -e

if [ ! -f id_rsa ]; then
	curl -o id_rsa https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant
fi

release=alpha
case $1 in
stable)	release=stable ;;
beta)	release=beta ;;
esac

packer build -var-file "vars-$release.json" coreos.json
