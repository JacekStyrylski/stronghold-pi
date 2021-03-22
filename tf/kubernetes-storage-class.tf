resource "kubernetes_storage_class" "sc" {
	metadata {
		name = local.storage-class-name
	}
	storage_provisioner = "kubernetes.io/no-provisioner"
	volume_binding_mode = "WaitForFirstConsumer"
}
