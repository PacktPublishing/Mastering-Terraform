source "googlecompute" "vm" {
  project_id   = var.gcp_project_id
  source_image = "ubuntu-pro-2204-jammy-v20240614"
  ssh_username = "packer"
  zone         = var.gcp_primary_region
  image_name   = "${var.image_name}-${var.image_version}"
}