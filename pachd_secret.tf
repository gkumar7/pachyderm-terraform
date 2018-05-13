resource "kubernetes_secret" "pachyderm-storage-secret" {
  metadata {
    name = "pachyderm-storage-secret"
    labels {
      app = "pachyderm"
      suite = "pachyderm"
    }
  }
  data {}
}