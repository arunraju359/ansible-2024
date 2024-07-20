pipeline {
    agent any

    environment {
        LOCAL_JAR_PATH = '/Users/arun/.jenkins/workspace/student-app/target/studentapp-studentapp.war' // Path where the JAR file will be built
        DEPLOY_DIR = '/usr/local/tomcat/webapps' // Directory where the JAR file will be deployed
        SCRIPT_DIR = '/usr/local/tomcat/bin'
        SCRIPT_FILE = '/usr/local/tomcat/bin/startup.sh'
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
                script {
                                                def scriptFile = sh(script: "ls ${env.SCRIPT_FILE}", returnStdout: true).trim()
                                                sh "./${env.SCRIPT_FILE}"
                }



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
