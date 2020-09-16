pipeline {
    environment {
        myimage = "zerocodebit/projectcapstone"
        targetCredential = 'dockerhub'
    }
        

     agent any
     stages {
         stage('Build') {
              steps {
                  sh 'echo Building...'
              }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Build Docker Image') {
              steps {
                  script{
                      myimage = docker.build myimage
                  }
                  
              }
         }
         stage('Push Docker Image') {
              steps {
                  
                  script{
                      myimage = docker.build myimage
                  }
                  
                  withDockerRegistry([url: "", credentialsId: "docker-hub"]) {
                      sh "docker tag projectcapstone zerocodebit/projectcapstone"
                      sh 'docker push zerocodebit/projectcapstone'
                  }
              }
         }
         stage('Deploying') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials: 'aws', region: 'us-east-2b') {
                      sh "aws eks --region us-east-2b update-kubeconfig --name capstonecluster"
                      sh "kubectl apply -f deployment/deployment.yml"
                      sh "kubectl get nodes"
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/projectcapstone"
                  }
              }
        }
        stage("Cleaning up") {
              steps{
                    echo 'Cleaning up...'
                    sh "docker system prune"
              }
        }
     }
}