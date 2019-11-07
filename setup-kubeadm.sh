#! /bin/sh

# https://kubernetes.io/docs/setup/independent/install-kubeadm/

CNI_VERSION="v0.8.2"
CRICTL_VERSION="v1.16.1"
KUBE_VERSION="v1.16.2"

setup() {
	mkdir -p /opt/cni/bin
	mkdir -p /opt/bin
}

install_cni() {
	curl -L "https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-amd64-${CNI_VERSION}.tgz" | tar -C /opt/cni/bin -xz
}

install_crictl() {
	curl -L "https://github.com/kubernetes-incubator/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-linux-amd64.tar.gz" | tar -C /opt/bin -xz
}


install_kube() {
	cd /opt/bin
	curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/{kubeadm,kubelet,kubectl}
	chmod +x {kubeadm,kubelet,kubectl}

	curl -sSL "https://raw.githubusercontent.com/kubernetes/kubernetes/${KUBE_VERSION}/build/debs/kubelet.service" | sed "s:/usr/bin:/opt/bin:g" > /etc/systemd/system/kubelet.service
	mkdir -p /etc/systemd/system/kubelet.service.d
	curl -sSL "https://raw.githubusercontent.com/kubernetes/kubernetes/${KUBE_VERSION}/build/debs/10-kubeadm.conf" | sed "s:/usr/bin:/opt/bin:g" > /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
}

setup
install_cni
install_crictl
install_kube
