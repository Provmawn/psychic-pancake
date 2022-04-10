node {
  def app
  stage ('Clone Repository') {
    checkout scm
  }

  stage ('Build Image') {
    app = docker.build("dev-test-api:${env.BUILD_ID}", './dockerfiles')
  }

  stage ('Test Python') {
    app.inside {
      sh 'python ./app/main.py'
    } 
  }
  post {
    success {
      sh 'passed'      
    }
    failure {
      sh 'failed'
    }
  }
  
}
