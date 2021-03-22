resource "kubernetes_persistent_volume_claim" "etc" {
	metadata {
		name = "pihole-local-etc-claim"
		namespace = kubernetes_namespace.ns.metadata[0].name
	}
	spec {
		storage_class_name = local.storage-class-name
		access_modes = [ "ReadWriteOnce" ]
		resources {
			requests = {
				"storage" = "1Gi"
			}
		}
		selector {
			match_labels = {
				"directory" = "etc"
			}
		}
	}
}

resource "kubernetes_persistent_volume_claim" "dnsmasq" {
	metadata {
		name = "pihole-local-dnsmasq-claim"
		namespace = kubernetes_namespace.ns.metadata[0].name
	}
	spec {
		storage_class_name = local.storage-class-name
		access_modes = [ "ReadWriteOnce" ]
		resources {
			requests = {
				"storage" = "500Mi"
			}
		}
		selector {
			match_labels = {
				"directory" = "dnsmasq.d"
			}
		}
	}
}
