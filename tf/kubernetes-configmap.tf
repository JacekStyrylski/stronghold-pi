resource "kubernetes_config_map" "cloudflare" {
	metadata {
		name = local.cloudflared-app_name
		namespace = kubernetes_namespace.ns.metadata[0].name
	}
	data = {
		# TODO: replace file with EOD
		"config.yml" = <<-EOT
			proxy-dns: true
			proxy-dns-port: ${var.proxy-dns-port}
			proxy-dns-address: 0.0.0.0
			proxy-dns-upstream:
			- ${var.proxy-dns-upstream[0]}
			- ${var.proxy-dns-upstream[1]}
			EOT
	}
}

# resource "kubernetes_config_map" "cloudflare" {
# 	metadata {
# 		name = "cloudflare-config"
# 		namespace = "pi-hole"
# 	}
# 	data = {
# 		"config.yml" = file("${path.module}/cloudflared-config.yml")
# 	}
# }

resource "kubernetes_config_map" "pihole" {
	metadata {
		name = local.pi_hole-app_name
		namespace = kubernetes_namespace.ns.metadata[0].name
	}
	data = {
		# PIHOLE_DNS_ = "${kubernetes_service.cloudflared.spec[0].cluster_ip}#${var.proxy-dns-port}"
		PIHOLE_DNS_ = "1.1.1.1; 1.0.0.1"
		TZ = var.pihole-time-zone
		DNSSEC = true
		ServerIP = kubernetes_service.pihole.status[0].load_balancer[0].ingress[0].ip
	}
}
