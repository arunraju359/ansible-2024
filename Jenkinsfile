pipeline {
    agent any

    environment {
        LOCAL_WAR_PATH = '/Users/arun/.jenkins/workspace/student-app/target/studentapp-studentapp.war' // Path pattern to find the WAR file
        DEPLOY_DIR = "${HOME}/deploy" // Directory where the WAR file will be deployed
        TOMCAT_DIR = "/usr/local/tomcat" // Path to Tomcat installation
        TOMCAT_WEBAPPS_DIR = "${TOMCAT_DIR}/webapps" // Tomcat webapps directory
        WAR_FILE = 'studentapp-studentapp.war' // Name of the WAR file
        DOCKER_IMAGE_NAME = 'backend'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from version control
                git(
                    url: 'https://github.com/arunraju359/ansible-2024.git/', // Replace with your repository URL
                    branch: 'withdocker', // Replace with your branch name
                    credentialsId: 'credentials' // Replace with your credentials ID
                )
            }
        }

        stage('Build') {
            steps {
                // Build the project using Maven
                sh 'mvn clean package'
            }
        }

        stage('Copy Artifact') {
            steps {
                // Find the built WAR file and copy it to the Tomcat webapps directory
                sh 'docker build -t ${env.DOCKER_IMAGE_NAME}:latest'
            }
        }

        stage('Run Docker container') {
            steps {
                // Stop Tomcat, wait a bit, and then start Tomcat
                sh 'docker run -d -p 8088:8080 ${env.DOCKER_IMAGE_NAME}:latest'
            }
        }

    }

    post {
        always {
            echo 'Deployment completed.'
        }
        failure {
            // Notify on failure
            echo 'Deployment failed.'
        }
    }
}
