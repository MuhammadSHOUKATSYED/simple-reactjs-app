pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/MuhammadSHOUKATSYED/simple-reactjs-app'
            }
        }
        
        stage('Dependency Installation') {
            steps {
                sh 'npm install' // Assuming npm is used for dependency management
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-web-app .'
            }
        }
        
        stage('Run Docker Image') {
            steps {
                sh 'docker run -p 8080:80 my-web-app'
            }
        }
        
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jenkindocker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker tag my-web-app $DOCKER_USERNAME/my-web-app'
                    sh 'docker push $DOCKER_USERNAME/my-web-app'
                }
            }
        }
    }
}
