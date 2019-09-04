pipeline {
    agent {
        docker {
            image 'maven:3-alpine' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
            stage('Checkout perion-automation'){
                steps{
                  sh 'mkdir -p ramp-lift-automation/src/main/resources/sealights && mkdir -p perion-automation'
                  dir("perion-automation")
                  {
                      git branch: 'master',
                      credentialsId: 'ut-israel-devops',
                      url: 'https://github.com/PerionNet/perion-automation.git'
                  }
                }
            }
            stage('Prepare ramp-lift-automation'){
    			steps{
                    script{
                        try{
                            sh '''
                            rm -rf target
                            cp perion-automation/java-maven/sealights.json src/main/resources/sealights/sealights.json
                            '''
                                currentBuild.result = 'SUCCESS'
                        }catch(Exception ex){
                            currentBuild.result = 'FAILURE'
                        }
                    }
    			}
    		}
    		stage('Prepare sealights'){
    			steps{
    			    dir("perion-automation"){
        			    build job: 'Sealights_Listeners'
        			    copyArtifacts filter: 'sl-build-scanner.jar, buildSessionId.txt', fingerprintArtifacts: true, projectName: 'Sealights_Listeners', selector: workspace(), target: '.'
    			    }
    			}
    		}
			stage('Listen'){
				steps{
                    script{
                        try{
                            sh '''
                            mv perion-automation/buildSessionId.txt src/main/resources/sealights/buildSessionId.txt
                            mv perion-automation/sl-build-scanner.jar src/main/resources/sealights/sl-build-scanner.jar
                            mv perion-automation/scripts/sl_token.txt src/main/resources/sealights/sl_token.txt
                            cd src/main/resources/sealights/
                            java -jar sl-build-scanner.jar -pom -configfile sealights.json -workspacepath ../../../../
                            '''
                            currentBuild.result = 'SUCCESS'
                        }catch(Exception ex){
                            currentBuild.result = 'FAILURE'
                        }
                    }
			   }
		   }
			stage('Test'){
				steps{
                    script{
                        try{
                            sh 'mvn clean install test -Dcucumber.options="--tags $TAGS_TO_RUN" -P remote,$ENVIRONMENT'
                            currentBuild.result = 'SUCCESS'
                        }catch(Exception ex){
                            currentBuild.result = 'FAILURE'
                        }
                    }
				}
			}
	}
	//post { 
	//	always { 
	//		cleanWs()
	//	}
	//}
}