resource "kubernetes_namespace" "ns" {
	metadata {
		name = "pi-hole"
	}
}
