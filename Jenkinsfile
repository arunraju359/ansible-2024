pipeline {
    agent any

    environment {
        LOCAL_WAR_PATH = '/Users/arun/.jenkins/workspace/student-app/target/studentapp-studentapp.war' // Path pattern to find the WAR file
        DEPLOY_DIR = "${HOME}/deploy" // Directory where the WAR file will be deployed
        TOMCAT_DIR = "/usr/local/tomcat" // Path to Tomcat installation
        TOMCAT_WEBAPPS_DIR = "${TOMCAT_DIR}/webapps" // Tomcat webapps directory
        WAR_FILE = 'studentapp-studentapp.war' // Name of the WAR file
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from version control
                git(
                    url: 'https://github.com/arunraju359/ansible-2024.git/', // Replace with your repository URL
                    branch: 'jenkins', // Replace with your branch name
                    credentialsId: 'creds' // Replace with your credentials ID
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
                script {
                    def warFile = sh(script: "ls ${env.LOCAL_WAR_PATH}", returnStdout: true).trim()
                    sh "cp ${warFile} ${env.TOMCAT_WEBAPPS_DIR}/${env.WAR_FILE}"
                }
            }
        }

        stage('Restart Tomcat') {
            steps {
                // Stop Tomcat, wait a bit, and then start Tomcat
                script {
                    echo 'Stopping Tomcat...'
                    def shutdownResult = sh(script: "${env.TOMCAT_DIR}/bin/shutdown.sh", returnStatus: true)
                    if (shutdownResult != 0) {
                        echo "Tomcat was not running or shutdown encountered an issue."
                    }
                    sleep 20 // Wait longer for Tomcat to shut down properly
                    echo 'Starting Tomcat...'
                    def startupResult = sh(script: "${env.TOMCAT_DIR}/bin/startup.sh", returnStatus: true)
                    if (startupResult != 0) {
                        error "Failed to start Tomcat."
                    }
                    echo 'Tomcat started successfully.'
                }
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
