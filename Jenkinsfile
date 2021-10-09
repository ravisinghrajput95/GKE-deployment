pipeline{
    agent any
    environment{
        PROJECT_ID = "$PROJECT_ID"
        CLUSTER_NAME = "$CLUSTER_NAME"
        LOCATION = "$LOCATION"
        CREDENTIALS_ID = 'My First Project'
    }
    stages{
        stage("Code checkout"){
            steps{
                git credentialsId: 'github', url: 'https://github.com/ravisinghrajput95/GKE-deployment.git'
            }
        }
        
        stage("Build"){
            steps{
                script{
                    app = docker.build("$DOCKER-HUB-USERNAME/hello:${env.BUILD_ID}")
                }
            }
        }
        
        stage("Push"){
            steps{
                script{
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        app.push("latest")
                        app.push("${env.BUILD_ID}")
                    }
                }
            }
        }
        
        stage ("Deploy to GKE"){
            steps{
                sh "sed -i 's/hello:latest/hello:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
    }
}