pipeline {
    agent any

    environment {
        ENV = "dev" // Or parameterize this
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/PearsonGrant24/TerraformPro.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    dir("envs/${ENV}") {
                        sh "terraform init -backend-config=backend.tfvars"
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    dir("envs/${ENV}") {
                        sh "terraform plan -var-file=terraform.tfvars -out=tfplan"
                    }
                }
            }
        }

        stage('Approval for Prod') {
            when {
                expression { return ENV == "prod" }
            }
            steps {
                input message: "Approve deployment to PROD?"
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    dir("envs/${ENV}") {
                        sh "terraform apply -auto-approve tfplan"
                    }
                }
            }
        }
    }
}
