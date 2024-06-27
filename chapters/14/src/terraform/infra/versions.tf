terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
  backend "gcs" {
  }
}

# Configure the GCP Provider
provider "google" {
  region = var.primary_region
}