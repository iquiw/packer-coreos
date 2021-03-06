#! /bin/sh

# https://kubernetes.io/docs/setup/independent/install-kubeadm/

CNI_VERSION="v0.8.5"
CRICTL_VERSION="v1.17.0"
KUBE_VERSION="v1.17.2"

setup() {
	mkdir -p /opt/cni/bin
	mkdir -p /opt/bin
}

install_cni() {
	curl -L "https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-linux-amd64-${CNI_VERSION}.tgz" | tar -C /opt/cni/bin -xz
}

install_crictl() {
	curl -L "https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-linux-amd64.tar.gz" | tar -C /opt/bin -xz
}


install_kube() {
	cd /opt/bin
	curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/{kubeadm,kubelet,kubectl}
	chmod +x {kubeadm,kubelet,kubectl}

	curl -sSL "https://raw.githubusercontent.com/kubernetes/kubernetes/${KUBE_VERSION}/build/debs/kubelet.service" | sed "s:/usr/bin:/opt/bin:g" > /etc/systemd/system/kubelet.service
	mkdir -p /etc/systemd/system/kubelet.service.d
	curl -sSL "https://raw.githubusercontent.com/kubernetes/kubernetes/${KUBE_VERSION}/build/debs/10-kubeadm.conf" | sed "s:/usr/bin:/opt/bin:g" > /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

	echo 'KUBELET_EXTRA_ARGS="--volume-plugin-dir=/var/lib/kubelet/volumeplugins"' > /etc/default/kubelet
}

setup
install_cni
install_crictl
install_kube
