pipeline{
    
    environment {
        imagename = "poc"     
        dockerImage = ''
    	registry = 'satishmittapelly/poc'
	    registryCredential = 'dockerhub_id'
     }
    
    agent any
    triggers {
                cron('H 15 * * *')
    }

    stages {
        stage('Build Repository Checkout') {
            steps{
                // Clean the workspace
                cleanWs()

                // Check out the build repository
                git branch: 'main', url: 'https://github.com/satish-mittapelly/POC.git'
            }
        }
        stage("Build artifact") {
	    steps {
	        sh '''
		   export M2_HOME=/opt/maven/apache-maven-3.9.1
		   export PATH=${M2_HOME}/bin:${PATH}
	           echo $M2_HOME
	           mvn clean install
	           chmod 755 *
	    	    withSonarQubeEnv('sonarqube-8.9.10') { 
                   sh "mvn sonar:sonar"
		'''	
		}
	    }
    }
          stage('SonarQube analysis') {
        steps{
            script {
        withSonarQubeEnv('sonarqube-8.9.10') { 
        sh "mvn sonar:sonar"
        }
                    }
        }
        }
        stage ("Building Docker Image") {
           steps {
               script {
                    sh ("cp target/poc-*.war .")
                    sh ("cp /home/ubuntu/tomcat.tar.gz .")
                    sh ("docker build --network=host -t " + imagename + " .")
                    dockerImage = docker.build registry 
                        }
                    }
                }
               
    	stage ('Upload Image') {
	       steps {
		        script {
			            docker.withRegistry( '', registryCredential ) {
			            dockerImage.push()
            			}
		}
	       }

    }
}
}
