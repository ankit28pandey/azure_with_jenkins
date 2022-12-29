pipeline {
    agent any

    stages {
        stage('Check code') {
            steps {
                git branch: 'main', url: 'https://github.com/ankit28pandey/azure_with_jenkins.git'
            }
        }
        stage('Install Terraform'){
            steps{
                sh ('wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo -S tee /usr/share/keyrings/hashicorp-archive-keyring.gpg')
                echo ('deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main') 
                sh ('sudo -S tee /etc/apt/sources.list.d/hashicorp.list')
                sh ('sudo -S apt update && sudo apt install terraform')
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
