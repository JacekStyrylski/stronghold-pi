resource "kubernetes_secret" "pihole" {
	metadata {
		name = local.pi_hole-app_name
		namespace = kubernetes_namespace.ns.metadata[0].name
	}
	data = {
		WEBPASSWORD = var.admin-password
	}
}
