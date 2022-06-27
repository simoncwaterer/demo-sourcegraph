locals {
  name = "backstage"
  
  tags = {
    Environment = var.environment
    ServiceCatalogueId = 1
    ServiceName = "myService"
  }
}
