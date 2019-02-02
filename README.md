# Packer CoreOS

## Prerequisite

### For packer build

* [VirtualBox](https://www.virtualbox.org)
* [packer](https://www.packer.io/)

### For maintenance

* [Container Linux Config Transpiler](https://github.com/coreos/container-linux-config-transpiler)
* [fx](https://github.com/antonmedv/fx)

Also `bash` and `curl` are used.

## Usage

Run `build.sh` with release type.

``` console
$ sh build.sh [alpha|beta|stable]
```

## Note

This box is intended to be used with manual IP address configuration.

IMO, network auto configuration for CoreOS guest of vagrant is broken.
This [ignition.json](https://github.com/iquiw/packer-coreos/blob/5da9f24827e6702ff4779b8493ae70c74ad4d8e4/ignition.json) somewhat works with auto configuration, but it is not compatible with kubeadm.
