resource "random_string" "random" {
  length = 10

    lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
  }
}
