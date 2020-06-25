library 'cb-days@master'
def testPodYaml = libraryResource 'podtemplates/vuejs/vuejs-test-pod.yml'
pipeline {
  agent none
  options { 
    buildDiscarder(logRotator(numToKeepStr: '2'))
    skipDefaultCheckout true
    preserveStashes(buildCount: 2)
  }
  environment {
    repoOwner = "gregavsyuk"
    credId = "microfrontend-git"
    registry = "docker.cb-demos.io"
  }
  stages('VueJS Test and Build')
  {
    stage('VueJS Tests') {
      agent {
        kubernetes {
          label 'nodejs'
          yaml testPodYaml
       }
      }
      steps {
            checkout scm           
            container('nodejs') {
              sh '''
                 yarn install
                 yarn test:unit
                 '''
            }
      } 
    }
    stage('Build and Push Image') {
      when {
        beforeAgent true
        branch 'master'
      }
      steps { 
        imgBuildNexus("microblog-frontend", "${repoOwner}", "${registry}")
        {
          checkout scm
        }
      }
    } 
  }
}
