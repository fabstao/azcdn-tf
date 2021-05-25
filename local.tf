resource "null_resource" "pwsh_local" {
  depends_on = [azurerm_cdn_endpoint.endpoints]
  provisioner "local-exec" {
    command = ".\\multioriginep.ps1 -ResourceGroup '${var.resgroup}' -CdnProfile '${var.cdnprofile}-${var.openv}' -Endpoint '${var.endpoint}-${var.openv}-${random_id.random-suffix.hex}' -OriginGroup '${var.origingroup}' -Origin1 '${var.origin_names[0]}' -Origin2 '${var.origin_names[1]}' -Hostname2 '${var.origin_hostnames[1]}' "
    #command     = ".\\multioriginep.ps1"
    working_dir = path.root
    interpreter = ["pwsh", "-Command"]
    #interpreter = ["bash"]
  }
}
