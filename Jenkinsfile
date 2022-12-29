pipeline {
    agent any

    stages {
        stage('Check code') {
            steps {
                git branch: 'main', url: 'https://github.com/ankit28pandey/azure_with_jenkins.git'
            }
        }
        stage('terraform init'){
            steps{
                sh ('terraform init')
            }
        }
        stage('terraform plan'){
            steps{
                sh ('terraform plan -out vm_with_jenkins.tfplan')
            }
        }
        stage('terraform apply'){
            steps{
                sh ('terraform apply vm_with_jenkins.tfplan')
            }
        }
    }
}
