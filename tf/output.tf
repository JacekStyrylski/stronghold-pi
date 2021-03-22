output "pi-hole-ip" {
  value = kubernetes_service.pihole.status[0].load_balancer[0].ingress[0].ip
}

output "cloudflared-config"{
	value = kubernetes_config_map.cloudflare.data
}
