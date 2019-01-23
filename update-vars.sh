#! /bin/sh

gen_url() {
	echo "https://$1.release.core-os.net/amd64-usr/current/$2"
}

iso_url() {
	gen_url "$1" "coreos_production_iso_image.iso"
}

digest_url() {
	gen_url "$1" "coreos_production_iso_image.iso.DIGESTS"
}

update_var() {
	release=$1
	url=$(digest_url "$release")

	digest=$(curl -fsL "$url" | awk '/[0-9a-f]{64}  coreos_production_iso_image.iso/ { print $1 }')

	echo "{\"iso_url\": \"$(iso_url $release)\", \"iso_checksum\": \"$digest\", \"release\": \"$release\" }" | fx .
}

update_var stable > vars-stable.json
update_var beta   > vars-beta.json
update_var alpha  > vars-alpha.json
