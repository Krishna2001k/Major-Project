pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Set Branch Name') {
            steps {
                script {
                    env.BRANCH_NAME = "${env.GIT_BRANCH}".replaceFirst(/^origin\//, '')
                }
            }
        }
        stage('Build Docker Image & Push') {
            steps {
                sh 'chmod +x ./build.sh'
                sh "./build.sh ${env.BRANCH_NAME}"
            }
        }
        stage('Deploy Application') {
            steps {
                sh 'chmod +x ./deploy.sh'
                sh "./deploy.sh ${env.BRANCH_NAME}"
            }
        }
    }
    triggers {
        githubPush()
    }
}
