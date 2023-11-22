resource "aws_instance" "instance" {
    ami                         = "ami-0fc5d935ebf8bc3bc"
    instance_type               = "t2.medium"
    associate_public_ip_address = true
    availability_zone           = "us-east-1a"
    subnet_id                   = aws_subnet.my_subnet.id
    vpc_security_group_ids      = [aws_security_group.my_security_group.id]
    tags                        = {Name = "EC2 Instance"}
    key_name                    = "project_access_key"

    connection {
        type                    = "ssh"
        user                    = "ubuntu"
        host                    = aws_instance.instance.public_ip
        private_key             = tls_private_key.rsa.private_key_pem
    }

    provisioner "file" {
        source      = "installation-scripts"
        destination = "/tmp/installation-scripts"
    }

    provisioner "remote-exec" {
        inline = [ 
            "chmod +x /tmp/installation-scripts/packages.sh",
            "/tmp/installation-scripts/packages.sh",
        ]
    }
}