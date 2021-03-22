resource "kubernetes_persistent_volume" "dnsmasq" {
	metadata {
		name = "pihole-local-dnsmasq-volume"
		labels = {
		  "directory" = "dnsmasq.d"
		}
	}
	spec {
		capacity = {
			"storage" = "1Gi"
		}
		access_modes = [ "ReadWriteOnce" ]
		persistent_volume_reclaim_policy = "Delete"
		storage_class_name = local.storage-class-name
		persistent_volume_source {
			local {
				path = var.volume-dnsmasq-location
			}
		}
		node_affinity {
			required {
				node_selector_term {
					match_expressions {
						key = "kubernetes.io/hostname"
						operator = "In"
						values = [ "ubuntu" ]
					}
				}
			}
		}
	}
}

resource "kubernetes_persistent_volume" "etc" {
	metadata {
		name = "pihole-local-etc-volume"
		labels = {
		  "directory" = "etc"
		}
	}
	spec {
		capacity = {
			"storage" = "1Gi"
		}
		access_modes = [ "ReadWriteOnce" ]
		persistent_volume_reclaim_policy = "Delete"
		storage_class_name = local.storage-class-name
		persistent_volume_source {
			local {
				path = var.volume-etc-location
			}
		}
		node_affinity {
			required {
				node_selector_term {
					match_expressions {
						key = "kubernetes.io/hostname"
						operator = "In"
						values = [ "ubuntu" ]
					}
				}
			}
		}
	}
}
