// Define the variables

// Docker Variables
def dockerPublisherName = "rahulraju"
def dockerRepoName = "php-app"

def buildNumber = currentBuild.number

def imageName = "${dockerPublisherName}/${dockerRepoName}:${buildNumber}"

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
                dockerImage = docker.build imageName
                echo "====++++ Build Successul ++++===="
            }
        }

        // Publish the image to docker registry
        stage('Publish') {
            steps {
                echo "====++++ Publish Stage ++++===="
                docker.withRegistry("https://docker.io/", 'f96da42a-1dd9-40d2-a1dc-b438971dbd53') {
                    dockerImage.push()
                    dockerImage.push('latest')
                }
                echo "====++++ Publish Successul ++++===="
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
