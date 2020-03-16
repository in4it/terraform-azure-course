resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource azurerm_storage_account "storage-account" {
  resource_group_name = azurerm_resource_group.demo.name
  location = azurerm_resource_group.demo.location
  name = "trainingsa${random_string.random-name.result}"

  account_kind = "StorageV2"
  account_replication_type = "LRS"
  account_tier = "Standard"
  is_hns_enabled = true
}

resource azurerm_storage_container "storage-container" {
  name = "trainingco${random_string.random-name.result}"
  storage_account_name = azurerm_storage_account.storage-account.name

}

resource azurerm_stream_analytics_job "stream-analytics" {
  resource_group_name = azurerm_resource_group.demo.name
  location = azurerm_resource_group.demo.location
  name = azurerm_resource_group.demo.name

  compatibility_level = "1.1"
  data_locale = "en-US"
  streaming_units = 1

  transformation_query = <<QUERY
    SELECT *
    INTO BlobOutput
    FROM IotHub
    HAVING Temperature > 25
QUERY
}

resource azurerm_stream_analytics_stream_input_iothub "streamInput" {
  resource_group_name = azurerm_resource_group.demo.name
  name = "IotHub"
  eventhub_consumer_group_name =  azurerm_iothub_consumer_group.consumer-group.name
  iothub_namespace = azurerm_iothub.iotHub.name
  endpoint = "messages/events"
  stream_analytics_job_name = azurerm_stream_analytics_job.stream-analytics.name
  shared_access_policy_key = azurerm_iothub_shared_access_policy.access-policy.primary_key
  shared_access_policy_name = azurerm_iothub_shared_access_policy.access-policy.name

  serialization {
    encoding = "UTF8"
    type = "Json"
  }
  depends_on = [
    azurerm_iothub_consumer_group.consumer-group,
  ]
}

resource "azurerm_stream_analytics_output_blob" "blob-output" {
  name                      = "BlobOutput"
  stream_analytics_job_name = azurerm_stream_analytics_job.stream-analytics.name
  resource_group_name       = azurerm_stream_analytics_job.stream-analytics.resource_group_name
  storage_account_name      = azurerm_storage_account.storage-account.name
  storage_account_key       = azurerm_storage_account.storage-account.primary_access_key
  storage_container_name    = azurerm_storage_container.storage-container.name
  path_pattern              = "outputs/{date}:{time}"
  date_format               = "yyyy-MM-dd"
  time_format               = "HH"

  serialization {
    encoding = "UTF8"
    type = "Json"
    format = "LineSeparated"
  }
}

#Only IOT hub related

resource azurerm_iothub "iotHub" {
  resource_group_name = azurerm_resource_group.demo.name
  location = azurerm_resource_group.demo.location
  name = "demo-stream-iot-iothub"

  sku {
    capacity = 1
    name = "F1"
    tier = "Free"
  }

  endpoint {
    type = "AzureIotHub.StorageContainer"
    name = "storage"
    connection_string = azurerm_storage_account.storage-account.primary_blob_connection_string
    container_name = azurerm_storage_container.storage-container.name
    file_name_format = "{iothub}/{YYYY}-{MM}-{DD}/{HH}-{mm}-{partition}"
    encoding = "avro"
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes = 314572800
  }

#built-in endpoint
  route {
    enabled = true
    name = "deviceToEvents"
    source = "DeviceMessages"
    endpoint_names = ["events"]
  }

  route {
    enabled = true
    name = "deviceToStorage"
    source = "DeviceMessages"
    endpoint_names = ["storage"]
  }
}

resource azurerm_iothub_consumer_group "consumer-group" {
  eventhub_endpoint_name = "events"
  iothub_name = azurerm_iothub.iotHub.name
  name = "cgstreamanalytics"
  resource_group_name = azurerm_iothub.iotHub.resource_group_name
  
  depends_on = [
    azurerm_iothub_shared_access_policy.access-policy,
  ]
}

resource azurerm_iothub_shared_access_policy "access-policy" {
  iothub_name = azurerm_iothub.iotHub.name
  resource_group_name = azurerm_iothub.iotHub.resource_group_name
  service_connect = true
  name = "access-streamanalytics"
}
