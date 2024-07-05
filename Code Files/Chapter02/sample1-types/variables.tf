variable "foo" {
  type = string
}
variable "bar" {
  type = number
}
variable "ok" {
  type = bool
}
variable "fizz" {
  type = list(any)
}
variable "buzz" {
  type = map(any)
}
variable "wizz" {
  type = object({
    a = string
    b = number
    c = bool
    d = list
    e = map
    f = object({
      one   = string
      two   = number
      three = bool
    })
  })
}