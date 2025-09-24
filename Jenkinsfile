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
                


        stage('Destroy infr'){
            steps{
                withAWS(credentials: 'aws-access-key-id', region: 'us-east-1'){
                    dir("Envs/${ENV}") {
                            sh "terraform destroy -auto-approve "
                        }
                }
            }
        }  
    }
}
