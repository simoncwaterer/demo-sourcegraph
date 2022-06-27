locals {
  name = "backstage"
  
  default_tags = {
    Environment = var.environment
    ServiceCatalogueId = 1
    ServiceName = "myService"
  }
}
