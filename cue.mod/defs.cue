// Import definitions straight from k8s api

import (
  "k8s.io/api/core/v1"
  apps_v1 "k8s.io/api/apps/v1"
)

// Basic definition for zee deployment
service: [ID=_]: v1.#Service & {
	apiVersion: "v1"
	kind: "Service"
	metadata: {
		name: ID
		labels: {
			app: ID // by convention
			domain: "prod" | "pre-prod" // some scenario
		}
	}
	spec: {
		type: "LoadBalancer" | "ClusterIP"  // Do not wanna any nodeports
		// Any port has the following properties.
		ports: [...{
			port: int & >79 & <81
			targetPort: 8080
			protocol: *"TCP" | "UDP"
			name: string | *"client"
		}]
		selector: metadata.labels // we want those to be the same
	}
}
deployment: [ID=_]: apps_v1.#Deployment & {
	apiVersion: "apps/v1"
	kind: "Deployment"
	metadata: name: ID
	spec: {
		// 1 is the default, but we allow any number
		replicas: *1 | int & < 3
		selector: matchLabels: {
			app: ID
		}
		template: {
			metadata: labels: {
				app: ID
				domain: "prod" | "pre-prod"
			}
			// we always have one namesake container
			spec: containers: [{
				name: ID
				image: #BlessedImage
				ports: [{
					containerPort: 8080
				}]
			}]
		}
	}
}

// Only two container images are allowed
#BlessedImage: "paulbouwer/hello-kubernetes:1.8" | "paulbouwer/hello-kubernetes:1.7"
#HappyLabel: {
	favourite_colour: "red" | "green" | "blue"
	...
}

// Prod deployment
service: "hello-dynatrace-prod": {
	metadata: labels: domain: "prod"
	spec: {
		type: "LoadBalancer"
		ports: [{
			port: 80
		}]
	}
}
deployment: "hello-dynatrace-prod": {
	spec: template:	{
		metadata: labels: domain: "prod"
			spec: containers: [{
				image: "paulbouwer/hello-kubernetes:1.8"
			}]
	}
}

// Preprod
// service: "hello-dynatrace-pre-prod": {
// 	metadata: labels: #HappyLabel & {
// 		domain: "pre-prod"
// 		favourite_colour: "blue"
// 	}
// 	spec: {
// 		type: "ClusterIP"
// 		ports: [{
// 			port: 80
// 		}]
// 	}
// }
// deployment: "hello-dynatrace-pre-prod": {
// 	spec: template:	{
// 		metadata: labels: domain: "pre-prod"
// 			spec: containers: [{
// 				image: "paulbouwer/hello-kubernetes:1.8"
// 			}]
// 	}
// }
