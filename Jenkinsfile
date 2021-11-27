// Define the variables

// Docker Variables
def dockerPublisherName = "rahulraju"
def dockerRepoName = "php-app"

def buildNumber = currentBuild.number

def imageName = "${dockerPublisherName}/${dockerRepoName}:${buildNumber}"
def imageNameLatestTag = "${dockerPublisherName}/${dockerRepoName}:latest"

def dockerImage

// Git Variables
def gitRepoName = "https://github.com/lRAHULl/rahul-php-sample-app.git"
def gitBranch = "master"

// Triggers
properties([pipelineTriggers([githubPush()])])

// Pipeline script
pipeline {
    // Agents
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('rahul-dockerhub')
    }

    // Stages In the pipeline
    stages {
        // Checkout from the Source Control
        stage('Checkout') {
            steps {
                echo "====++++ Checkout Stage ++++===="
                git branch: "${gitBranch}", url: "${gitRepoName}"
                echo "====++++ Checkout Successful ++++===="    
            }
        }

        // Test the code
        stage('Test') {
            steps {
                echo "====++++ Testing ++++===="
                echo "====++++ Tests Skipped ++++===="
            }
        }

        // Build the Docker image
        stage('Build') {
            steps {
                echo "====++++ Build Stage ++++===="
                sh "docker build -t ${imageName} ."
                sh "docker build -t ${imageNameLatestTag} ."
                echo "====++++ Build Successul ++++===="
            }
        }

        // Login to docker registry
        stage('Login') {
            steps {
                echo "====++++ Docker Login ++++===="
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                echo "====++++ Login Successul ++++===="
            }
        }

        // Publish the image to docker registry
        stage('Publish') {
            steps {
                echo "====++++ Publish Stage ++++===="
                sh "docker push ${imageName}"
                sh "docker push ${imageNameLatestTag}"
                echo "====++++ Publish Successul ++++===="
            }
        }

        // Deploy
        stage('Deploy - Dev') {
            steps {
                input "Deploy to Dev?"
                sh "export KUBECONFIG=/var/lib/jenkins/workspace/rahul-eks/kubeconfig_rahulp-test-cluster"
                sh "helm upgrade rahul-php-app ./helm/ --set app.image=${imageName}"
            }
        }

        // Clean the system.
        stage('Cleanup') {
            steps {
                echo "====++++ Cleanup Stage ++++===="
                sh "docker rmi ${imageName}"
                echo "====++++ Cleanup Stage ++++===="
            }
        }
    }
}
