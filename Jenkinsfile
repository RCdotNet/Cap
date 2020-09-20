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
         stage('Deploying1') {
              steps{
                  echo 'Deploying to AWS...'
                  withAWS(region: 'us-west-2',credentials: 'AWSCred') {
                    sh 'aws sts get-caller-identity'
                    sh 'echo Kubeconfig: $KUBECONFIG'
                      sh 'aws eks update-kubeconfig --name capstonecluster'
                  }
              }
        }
        stage("Deploying and Cleaning up") {
              steps{
                    echo 'Cleaning up...'
                    sh '''
                    kubectl rollout status deployment/projectcapstone
                    kubectl get nodes
                    kubectl get deployment
                    kubectl get pod -o wide
                    kubectl get service/projectcapstone
                    docker system prune
                    '''
              }
        }
     }
}