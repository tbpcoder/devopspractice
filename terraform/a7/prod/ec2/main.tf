resource "null_resource" "hello_printer" {
  provisioner "local-exec" {
    command = "echo Deployes ec2 from production module"
  }
}