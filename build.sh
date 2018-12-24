#! /bin/sh

set -e

if [ ! -f id_rsa ]; then
	curl -o id_rsa https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant
fi

ct -pretty -in-file ignition.yml | fx 'x => {
   x.systemd.units[0].dropins[0].contents += "\n[Install]\nAlias = etcd.service";
   return x
}' > ignition.json

release=alpha
case $1 in
stable)	release=stable ;;
esac

packer build -var-file "vars-$release.json" coreos.json
