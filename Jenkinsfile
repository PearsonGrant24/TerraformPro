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
                
        stage('Create s3 bucket of not existing') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-access-key-id'
                ]]) {
                    sh '''
                    echo "Creating bucket pract-terraform-122347..."

                    
                    aws s3api create-bucket --bucket pract-terraform-122347 --region us-east-1
                    
                    '''
                }
            }
        }

       
        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-access-key-id', region: 'us-east-1') {
                    dir("Envs/${ENV}") {
                        sh "terraform init"
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-access-key-id', region: 'us-east-1') {
                    dir("Envs/${ENV}") {
                        sh "terraform plan -var-file=terraform.tfvars -out=tfplan"
                    }
                }
            }        }

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
                withAWS(credentials: 'aws-access-key-id', region: 'us-east-1') {
                    dir("Envs/${ENV}") {
                        sh "terraform apply -auto-approve tfplan"
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                withAWS(credentials: 'aws-access-key-id', region: 'us-east-1') {
                    dir("Envs/${ENV}") {
                        sh "terraform destroy -auto-approve tfplan"
                    }
                }
            }
        }
    }
}
