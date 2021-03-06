package crm

deployment: {
  apiVersion: "apps/v1",
  kind: "Deployment",
  metadata: name: "crm-deployment",
  spec: {
    selector: {
      matchLabels: {
        app: "crm"
      }
    }
    replicas: *1 | int,
    template: {
      metadata: {
        labels: {
          app: "crm",
        }
      }
      spec: {
        serviceAccount: "crm-serviceaccount",
        containers: [
          { name: "crm-api",
            image: "grasscrm:1.2",
            livenessProbe: {
              httpGet: {
                path: "/",
                port: "https",
              }
            }
            readinessProbe: {
              httpGet: {
                path: "/",
                port: "https",
              }
            }
          }]
       }
    }
  }
}
