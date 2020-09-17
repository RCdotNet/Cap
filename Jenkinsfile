pipeline {
    environment {
        myimage = "rcdotnet/projectcapstone"
        targetCredential = 'Docker'
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
                      docker.withRegistry( '', targetCredential ){
                          myimage.push()
                      }
                  }

            }
         }
         stage('Deploying') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(region: 'us-west-2',credentials: 'AWSCred') {
                    sh 'aws sts get-caller-identity'
                      sh 'aws eks update-kubeconfig --name capstonecluster'
                      sh 'kubectl apply -f deployment/deployment.yml'
                      sh 'kubectl get nodes'
                      sh 'kubectl get deployment'
                      sh 'kubectl get pod -o wide'
                      sh 'kubectl get service/projectcapstone'
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