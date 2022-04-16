output "private_ip" {
  value = aws_spot_instance_request.new_vm_ec2.private_ip
}

output "public_ip" {
  value = aws_spot_instance_request.new_vm_ec2.public_ip
}
