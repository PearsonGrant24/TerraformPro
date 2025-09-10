pipeline {
    agent any

    environment {
        TF_VERSION = "1.7.5"
        ENV = "dev" // change this in multibranch jobs or use params
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/PearsonGrant24/TerraformPro.git'
            }
        }
    }
}