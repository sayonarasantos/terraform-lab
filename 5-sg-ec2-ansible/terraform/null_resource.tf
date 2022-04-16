resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    command = <<EOT
      export ANSIBLE_HOST_KEY_CHECKING=False
      ansible-playbook ../ansible/site.yaml --private-key ${var.private_key_path} -i '${aws_instance.new_vm_ec2.public_ip},' --user=${var.ssh_user}
    EOT
  }

  depends_on = [
    aws_instance.new_vm_ec2
  ]
}