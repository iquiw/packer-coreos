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
