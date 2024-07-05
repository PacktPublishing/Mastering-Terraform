locals {
  foo = format("rg-%s%s%s", var.fizz, var.buzz, var.wizz)
}