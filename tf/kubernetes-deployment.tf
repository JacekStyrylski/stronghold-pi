resource "kubernetes_deployment" "clodflared" {
	metadata {
		name = local.cloudflared-app_name
		namespace = kubernetes_namespace.ns.metadata[0].name
		labels = {
			"app" = local.cloudflared-app_name
		}
	}
	spec {
		replicas = "1"
		selector {
			match_labels = {
				"app" = local.cloudflared-app_name
			}
		}
		template {
			metadata {
				labels = {
					"app" = local.cloudflared-app_name
					"name" = local.cloudflared-app_name
				}
			}
			spec {
				container {
					name = local.cloudflared-app_name
					image = "ghcr.io/jacekstyrylski/cloudflared:1.7"
					image_pull_policy = "Always"
					# args = [ "proxy-dns --port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query" ]
					
					volume_mount {
						name = "cloudflare-volume"
						mount_path = "/etc/cloudflared"
					}
					port {
						container_port = var.proxy-dns-port
					}
				}
				volume {
					name = "cloudflare-volume"
					config_map {
						name = kubernetes_config_map.cloudflare.metadata[0].name
						items {
							key = "config.yml"
							path = "config.yml"
						}
					}
				}
			}
		}
	}
}

resource "kubernetes_deployment" "pihole" {
	metadata {
		name = local.pi_hole-app_name
		namespace = kubernetes_namespace.ns.metadata[0].name
		labels = {
			"app" = local.pi_hole-app_name
		}
	}
	spec {
		replicas = "1"
		selector {
			match_labels = {
				"app" = local.pi_hole-app_name
			}
		}
		template {
			metadata {
				labels = {
					"app" = local.pi_hole-app_name
					"name" = local.pi_hole-app_name
				}
			}
			spec {
				container {
					name = local.pi_hole-app_name
					image = "pihole/pihole:latest"
					image_pull_policy = "Always"
					env_from {
						secret_ref {
							name = kubernetes_secret.pihole.metadata[0].name
						}
					}
					env_from {
						config_map_ref {
							name = kubernetes_config_map.pihole.metadata[0].name
						}
					}
					volume_mount {
						name = "pihole-local-etc-volume"
						mount_path = "/etc/pihole"
					}
					volume_mount {
						name = "pihole-local-dnsmasq-volume"
						mount_path = "/etc/dnsmasq.d"
					}
					security_context {
						capabilities {
							add = [ "NET_ADMIN" ]
						}
					}
				}
				volume {
					name = "pihole-local-etc-volume"
					persistent_volume_claim {
						claim_name = "pihole-local-etc-claim"
					}
				}
				volume {
					name = "pihole-local-dnsmasq-volume"
					persistent_volume_claim {
						claim_name = "pihole-local-dnsmasq-claim"
					}
				}
			}
		}
	}
}
