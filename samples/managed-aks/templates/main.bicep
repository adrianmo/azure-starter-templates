targetScope = 'resourceGroup'

param aksName string
param location string
param nodeCount int
param nodeSize string
param adminUsername string
@secure()
param adminPassword string
param sshPublicKey string
param vnetName string
param subnetName string

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: '${aksName}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: '${aksName}-subnet'
  dependsOn: [
    vnet
  ]
  properties: {
    addressPrefix: '10.0.0.0/24'
  }
}

resource aks 'Microsoft.ContainerService/managedClusters@2021-07-01' = {
  name: aksName
  location: location
  dependsOn: [
    subnet
  ]
  properties: {
    kubernetesVersion: '1.21.2'
    dnsPrefix: aksName
    agentPoolProfiles: [
      {
        name: 'nodepool1'
        count: nodeCount
        vmSize: nodeSize
        osType: 'Linux'
        osDiskSizeGB: 30
        vnetSubnetID: subnet.id
        maxPods: 110
        type: 'VirtualMachineScaleSets'
        mode: 'System'
        availabilityZones: []
        enableAutoScaling: true
        minCount: 1
        maxCount: 5
      }
    ]
    servicePrincipalProfile: {
      clientId: '00000000-0000-0000-0000-000000000000'
      secret: adminPassword
    }
    linuxProfile: {
      adminUsername: adminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshPublicKey
          }
        ]
      }
    }
    networkProfile: {
      networkPlugin: 'azure'
      serviceCidr: '10.0.0.0/16'
      dnsServiceIP: '10.0.0.10'
      dockerBridgeCidr: '172.17.0.1/16'
    }
    addonProfiles: {
      httpApplicationRouting: {
        enabled: true
      }
    }
  }
}
