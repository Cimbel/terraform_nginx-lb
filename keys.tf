resource "aws_key_pair" "new_key" {
  key_name   = "my_new_key"
  public_key = file("~/.ssh/id_rsa.pub")
}
