#service: {
    apiVersion: "v1"
    kind:       "Service"
    metadata: {
        name: string
        labels: {
            app:       metadata.name    // by convention
            domain:    "prod"  // always the same in the given files
            component: string  // varies per directory
        }
    }
    spec: {
        // Any port has the following properties.
        ports: [...{
            port:       int
            protocol:   *"TCP" | "UDP"      // from the Kubernetes definition
            name:       string | *"client"
        }]
        selector: metadata.labels // we want those to be the same
    }
}

svc_example: #service & {
  metadata: {
    name: "test"
    labels: {
      component: "testing"
    }
  }
  spec: {
    ports: [
      {
        port: 8080
      }
    ]
  }
}