output "pet_name" {
  value = random_pet.server.id
}
output "id" {
  value = {
    id      = random_id.server.id
    hex     = random_id.server.hex
    dec     = random_id.server.dec
    b64_std = random_id.server.b64_std
    b64_url = random_id.server.b64_url
  }
}