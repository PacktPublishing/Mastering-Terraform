resource "random_pet" "server" {
  keepers = {
    always = timestamp()
  }
}
resource "random_id" "server" {
  byte_length = 8
}