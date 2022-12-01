resource "null_resource" "installnginx" {
provisioner "remote-exec" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get -y install nginx"
  ]

      connection {
        type="ssh"
        user="linuxusr"
        private_key = file("${local_file.linuxpemkey.filename}")
        host ="${azurerm_public_ip.appip.ip_address}"
      }
    }

    depends_on = [
      local_file.linuxpemkey,
      azurerm_linux_virtual_machine.linuxvm
    ]
}