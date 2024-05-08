variable "dns_zone_name" {
  type = string
}
resource "azurerm_dns_zone" "main" {
  resource_group_name = azurerm_resource_group.web.name
  name                = var.dns_zone_name
}

data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }
}

resource "azurerm_dns_a_record" "apex" {
  resource_group_name = azurerm_dns_zone.main.resource_group_name
  zone_name           = azurerm_dns_zone.main.name
  name                = "@"
  records             = [
    data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.ip
  ]
  ttl                 = 60
}

resource "azurerm_dns_a_record" "wildcard" {
  resource_group_name = azurerm_dns_zone.main.resource_group_name
  zone_name           = azurerm_dns_zone.main.name
  name                = "*"
  records             = [
    data.kubernetes_service.ingress_nginx.status.0.load_balancer.0.ingress.0.ip
  ]
  ttl                 = 60
}
