locals {
  # Iterating over a list

  # generating a list
  region_names_list = [for s in var.regions : upper("${s.region}${s.country}")]
  # generating an object
  region_config_object = {
    for s in var.regions : "${s.region}${s.country}" =>
    {
      node_count = s.node_count
    }
  }

}

locals {
  # Iterating over a map

  # generating a list
  region_array_from_map = [
    for k, v in var.region_map :
    {
      region        = k,
      address_space = v.address_space
      node_count    = v.node_count
    }
  ]

}