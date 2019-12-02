resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource "azurerm_cosmosdb_account" "db" {
  name                = "training-cosmos-db-${random_string.random-name.result}"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  enable_automatic_failover = true

  is_virtual_network_filter_enabled = true

  virtual_network_rule {
    id = azurerm_subnet.demo-internal-1.id
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }

  geo_location {
    prefix            = "cosmosdb-s${random_string.random-name.result}-main"
    location          = azurerm_resource_group.demo.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_mongo_database" "mongo-example-database" {
  name                = "trainig-cosmos-mongo-db"
  resource_group_name = azurerm_resource_group.demo.name
  account_name        = azurerm_cosmosdb_account.db.name
}

resource "azurerm_cosmosdb_mongo_collection" "mongo-example-collection" {
  name                = "training-cosmos-mongo-db"
  resource_group_name = azurerm_resource_group.demo.name
  account_name        = azurerm_cosmosdb_account.db.name
  database_name       = azurerm_cosmosdb_mongo_database.mongo-example-database.name

  default_ttl_seconds = "777"
  shard_key           = "uniqueKey"

  indexes {
    key    = "aKey"
    unique = false
  }

  indexes {
    key    = "uniqueKey"
    unique = true
  }
}