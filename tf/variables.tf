variable "host" {
  type = string
}

variable "token" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

variable "admin-password" {
	type = string
}

variable "proxy-dns-port" {
	type = number
	default = 5053
}

variable "proxy-dns-upstream" {
	type = list
	default = [
		"https://1.1.1.1/dns-query",
		"https://1.0.0.1/dns-query"
		]
}

variable "pihole-time-zone" {
	type = string
}

variable "volume-etc-location" {
	type = string
	default = "/var/pi-hole-docker/etc"
}

variable "volume-dnsmasq-location" {
	type = string
	default = "/var/pi-hole-docker/dnsmasq"
}
