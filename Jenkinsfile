library 'cb-days@master'
def testPodYaml = libraryResource 'podtemplates/vuejs/vuejs-test-pod.yml'
pipeline {
  agent none
  options { 
    skipDefaultCheckout true
    preserveStashes(buildCount: 2)
  }
  environment {
    repoOwner = "gregavsyuk"
    repository = "microblog-frontend"
    credId = "microfrontend-git"
    registry = "docker.cb-demos.io"
    gcpProject = "cb-days-workshop"
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
        anyOf { branch 'master'; branch 'development' }
      }
      steps { 
        kanikoBuildPushGeneric("vuejs-app/${repoOwner}/${repository}", "latest", "${gcpProject}") {
          checkout scm
          gitShortCommit()
          stash name: "k8s-deploy", includes: ".kubernetes/**"
        }
      }
    }
    stage('Trigger CD') {
      when{
        beforeAgent true
        anyOf { branch 'master'; branch 'development' }
      }
      steps{
        cloudBeesFlowTriggerRelease configuration: 'LL-CD', projectName: 'Default', releaseName: 'Greg_test', startingStage: 'Readiness'
      }
    }
  }
}
