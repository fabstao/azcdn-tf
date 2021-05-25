
# ***************************
# CDN Checking origin group
# (C) 2021 Rackspace
# ***************************

resource "random_id" "random-suffix" {
  byte_length = 4
}

locals {
  hostname = "demoblobstatblob.z13.web.core.windows.net"
}

resource "azurerm_cdn_profile" "main" {
  depends_on = [azurerm_resource_group.suracdn]
  name       = "${var.cdnprofile}-${var.openv}"
  #name                = cdnprofile
  location            = var.lzlocation
  resource_group_name = var.resgroup
  sku                 = "Standard_Microsoft"

  tags = {
    iac-deployer = "terraform"
    iac-module   = "cdn-https-endpoint"
    appid-or-sso = "fabi8483" #REMOVE THIS!!
  }
}

resource "azurerm_cdn_endpoint" "endpoints" {
  name = "${var.endpoint}-${var.openv}-${random_id.random-suffix.hex}"
  #name                   = var.endoint
  profile_name           = azurerm_cdn_profile.main.name
  location               = var.lzlocation
  resource_group_name    = var.resgroup
  is_http_allowed        = false
  is_https_allowed       = true
  is_compression_enabled = true
  origin_host_header     = var.origin_hostnames[0]
  content_types_to_compress = [
    "application/eot",
    "application/font",
    "application/font-sfnt",
    "application/javascript",
    "application/json",
    "application/opentype",
    "application/otf",
    "application/pkcs7-mime",
    "application/truetype",
    "application/ttf",
    "application/vnd.ms-fontobject",
    "application/xhtml+xml",
    "application/xml",
    "application/xml+rss",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/x-httpd-cgi",
    "application/x-javascript",
    "application/x-mpegurl",
    "application/x-opentype",
    "application/x-otf",
    "application/x-perl",
    "application/x-ttf",
    "font/eot",
    "font/ttf",
    "font/otf",
    "font/opentype",
    "image/svg+xml",
    "text/css",
    "text/csv",
    "text/html",
    "text/javascript",
    "text/js",
    "text/plain",
    "text/richtext",
    "text/tab-separated-values",
    "text/xml",
    "text/x-script",
    "text/x-component",
    "text/x-java-source"
  ]

  origin {
    name      = var.origin_names[0]
    host_name = var.origin_hostnames[0]
  }

  delivery_rule {
    name  = "RedirectHTTPS"
    order = 1

    request_scheme_condition {
      operator         = "Equal"
      negate_condition = false
      match_values     = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }

  tags = {
    iac-deployer = "terraform"
    iac-module   = "cdn-https-endpoint"
    appid-or-sso = "fabi8483" #REMOVE THIS!!
  }
}
