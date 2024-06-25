application_name          = "fleet-app"
environment_name          = "dev"
primary_region            = "westus3"
domain_name               = "cloud-stack.io"
vnet_cidr_block           = "10.137.0.0/22"
az_count                  = 2
aks_orchestration_version = "1.26.6"
aks_system_pool = {
  vm_size        = "Standard_D2s_v3"
  min_node_count = 2
  max_node_count = 3
}
aks_workload_pool = {
  vm_size        = "Standard_F8s_v2"
  min_node_count = 2
  max_node_count = 3
}
container_registry_pushers = ["466a3a08-bd10-4a07-be0f-327a2de48073"]
keyvault_readers           = ["43072cf2-ef02-43cb-99b5-c480a67550f0"]
keyvault_admins            = ["43072cf2-ef02-43cb-99b5-c480a67550f0"]
k8s_service_account_name   = "workload"
k8s_namespace              = "app"
database_admin_username    = "psqladmin"