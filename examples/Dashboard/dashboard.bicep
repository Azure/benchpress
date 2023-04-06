param dashboardName string = 'dash${take(uniqueString(resourceGroup().id), 5)}'
param dashboardDisplayName string = 'Sample Dashboard'
param location string = resourceGroup().location

resource dashboard 'Microsoft.Portal/dashboards@2020-09-01-preview' = {
  name: dashboardName
  location: location
  tags: {
    'hidden-title': dashboardDisplayName
  }
  properties: {
    lenses: [
      {
        order: 0
        parts: [
          {
            position: {
              x: 0
              y: 0
              colSpan: 4
              rowSpan: 6
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '## Test Dashboard\r\nThis is a test dashboard.'
                  }
                }
              }
            }
          }
        ]
    }]
  }
}
