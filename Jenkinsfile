pipeline {
    agent {
        docker {
            image 'my-terraform-awscli:1.7.5'
            args '--entrypoint=""' //to avoid permissions issues
        }
    }

    environment {
        ENV = "dev" //
        AWS_DEFAULT_REGION = "us-east-1"
    }

    stages {
                
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/PearsonGrant24/TerraformPro.git'
            }
        }

        stage('Create s3 bucket of not existing'){
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]){
                sh '''
                    if ! aws s3api head-bucket --bucket pract-terraform-122347 2>/dev/null; then
                        echo "Creating bucket pract-terraform-122347........."
                        aws s3api create-bucket --bucket pract-terraform-122347 --region us-east-1

                    else
                        echo "bucket already exist, skipping......"
                    fi
                    '''
                    }
                }
            }
       
        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    dir("Envs/${ENV}") {
                        sh "terraform init"
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-creds', region: 'us-east-1') {
                    dir("Envs/${ENV}") {
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
                    dir("Envs/${ENV}") {
                        sh "terraform apply -auto-approve tfplan"
                    }
                }
            }
        }
    }
}
