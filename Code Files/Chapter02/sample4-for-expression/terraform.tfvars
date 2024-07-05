regions = [
  {
    country       = "us"
    region        = "west"
    address_space = "10.0.0.0/24"
    node_count    = 8
  },
  {
    country       = "us"
    region        = "east"
    address_space = "10.0.1.0/24"
    node_count    = 5
  }
]
region_map = {
  westus = {
    address_space = "10.0.0.0/24"
    node_count    = 8
  }
  eastus = {
    address_space = "10.0.1.0/24"
    node_count    = 5
  }
}