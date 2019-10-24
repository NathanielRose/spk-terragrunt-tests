resource "azurerm_eventhub_namespace" "test" {
  name                = "acceptanceTestEventHubNamespace"
  location            = "${data.azurerm_resource_group.cluster_rg.location}"
  resource_group_name = "${data.azurerm_resource_group.cluster_rg.name}"
  sku                 = "Standard"
  capacity            = 1
  kafka_enabled       = false

  tags = {
    environment = "Production"
  }
}

resource "azurerm_eventhub" "test" {
  name                = "acceptanceTestEventHub"
  namespace_name      = "${azurerm_eventhub_namespace.test.name}"
  resource_group_name = "${data.azurerm_resource_group.cluster_rg.name}"
  partition_count     = 2
  message_retention   = 1
}
