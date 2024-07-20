pipeline {
    agent any

    environment {
        LOCAL_JAR_PATH = '/Users/arun/.jenkins/workspace/student-app/target/studentapp-studentapp.war' // Path where the JAR file will be built
        DEPLOY_DIR = '/Users/arun/teach/artifacts' // Directory where the JAR file will be deployed
        JAVA_APP_PORT = 8081
    }

    stages {
        stage('Checkout') {
                    steps {
                        // Checkout the code from version control
                        git(
                            url: 'https://github.com/arunraju359/ansible-2024.git', // Replace with your repository URL
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
                            // Find the built JAR file and copy it to the deployment directory
                            script {
                                def jarFile = sh(script: "ls ${env.LOCAL_JAR_PATH}", returnStdout: true).trim()
                                sh "cp ${jarFile} ${env.DEPLOY_DIR}/studentapp-studentapp.war"
                            }
            }
        }

        stage('Deploy') {
            steps {
                // Kill any running instance of the application (optional)
                sh "pkill -f 'java -jar' || true"

                // Run the JAR file
                sh """
                    nohup java -jar ${DEPLOY_DIR}/studentapp-studentapp.war > /dev/null 2>&1 &
                """
                sh """
                                    nohup java -jar ${env.DEPLOY_DIR}/studentapp-studentapp.war --server.port=${env.JAVA_APP_PORT}"""
            }
        }
    }

    post {
        always {
            // Cleanup or notifications if necessary
            echo 'Deployment completed.'
        }
        failure {
            // Notify on failure
            echo 'Deployment failed.'
        }
    }
}
