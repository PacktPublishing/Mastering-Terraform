terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13.2"
    }
  }
  backend "gcs" {
  }
}

# Configure the GCP Provider
provider "google" {
  region  = var.primary_region
  project = var.gcp_project
}

data "google_container_cluster" "main" {
  name     = var.cluster_name
  location = var.primary_region
}

data "google_client_config" "current" {
}

provider "kubernetes" {

  token                  = data.google_client_config.current.access_token
  host                   = data.google_container_cluster.main.endpoint
  client_certificate     = base64decode(data.google_container_cluster.main.master_auth.0.client_certificate)
  client_key             = base64decode(data.google_container_cluster.main.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(data.google_container_cluster.main.master_auth.0.cluster_ca_certificate)

}


provider "helm" {
  kubernetes {
    token                  = data.google_client_config.current.access_token
    host                   = data.google_container_cluster.main.endpoint
    client_certificate     = base64decode(data.google_container_cluster.main.master_auth.0.client_certificate)
    client_key             = base64decode(data.google_container_cluster.main.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(data.google_container_cluster.main.master_auth.0.cluster_ca_certificate)
  }
}