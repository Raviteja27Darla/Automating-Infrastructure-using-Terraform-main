output "get_instance_name" {
    value = aws_instance.instance.tags.Name
}   
output "get_public_ip" {
    value = aws_instance.instance.public_ip
}  


