param location string = resourceGroup().location
param storageAccountNamePrefix string
param storageAccountType string
param tagsByResource object = {}

var storageAccountName = '${storageAccountNamePrefix}${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageAccountType
  }
  tags: contains(tagsByResource, 'storageAccount') ? tagsByResource.storageAccount : {}
}

output storageAccountEndpoint string = storageAccount.properties.primaryEndpoints.blob
