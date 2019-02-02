#! /bin/sh

ct -pretty -in-file ignition.yml | fx 'x => {
   x.systemd.units[0].dropins[0].contents += "\n[Install]\nAlias = etcd.service";
   return x
}' > ignition.json
