resource "template_dir" "init" {
  destination_dir = "${path.module}/files"

  vars = {
    foo = 42
    bar = "New England Clam Chowder"
  }

  # Add the source_dir argument here
  source_dir = "path/to/your/templates"  # Replace with the actual path
}
