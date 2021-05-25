resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}