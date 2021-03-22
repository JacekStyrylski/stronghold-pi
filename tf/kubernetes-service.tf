resource "kubernetes_service" "pihole" {
	metadata {
		namespace = kubernetes_namespace.ns.metadata[0].name
		labels = {
			"app" = local.pi_hole-app_name
		}
	}
	spec {
		type = "LoadBalancer"
		selector = {
			"app" = local.pi_hole-app_name
		}
		port {
			name = "pihole-admin"
			port = 80
			target_port = "80"
		}
		port {
			name = "dns-tcp"
			port = 53
			target_port = "53"
			protocol = "TCP"
		}
		port {
			name = "dns-udp"
			port = 53
			target_port = "53"
			protocol = "UDP"
		}
		port {
			name = "dhcp-udp"
			port = 67
			target_port = "67"
			protocol = "UDP"
		}
		port {
			name = "pihole-admin-https"
			port = 443
			target_port = "443"
			protocol = "TCP"
		}
	}
}

resource "kubernetes_service" "cloudflared" {
	metadata {
		name = local.cloudflared-app_name
		namespace = kubernetes_namespace.ns.metadata[0].name
		labels = {
			"app" = local.cloudflared-app_name
		}
	}
	spec {
		type = "LoadBalancer"
		selector = {
			"app" = local.cloudflared-app_name
		}
		port {
			port = var.proxy-dns-port
			target_port = var.proxy-dns-port
		}
	}
}
