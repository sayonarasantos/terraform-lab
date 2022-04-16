resource "null_resource" "base_config" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file(var.private_key_path)
    host        = aws_instance.new_vm_ec2.public_ip
  }

  provisioner "file" {
    source      = "scripts/basic-config.sh"
    destination = "~/basic-config.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/basic-config.sh",
      "sudo ~/basic-config.sh",
      "rm ~/basic-config.sh"
    ]
  }

  depends_on = [
    aws_instance.new_vm_ec2
  ]
}