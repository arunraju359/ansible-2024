pipeline {
    agent any

    environment {
        LOCAL_JAR_PATH = '/Users/arun/teach/ansible-2024/target/studentapp-studentapp.war' // Path where the JAR file will be built
        DEPLOY_DIR = '/Users/arun/teach/artifacts' // Directory where the JAR file will be deployed
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from version control
                git 'https://github.com/arunraju359/ansible-2024.git' // Replace with your repository URL
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
                // Copy the built JAR file to the deployment directory
                script {
                    def jarFile = findFiles(glob: "${LOCAL_JAR_PATH}")[0]
                    sh "cp ${jarFile} ${DEPLOY_DIR}/"
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
