resource "random_id" "current" {
  keepers = {
    deployment_id = "${var.deployment_id}"
  }
  byte_length = 8
}
