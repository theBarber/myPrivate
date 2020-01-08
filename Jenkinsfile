pipeline {
    agent any
    stages {
        stage('Get credentials') {
            steps {
                dir('perion-automation') {
                    git(
                        credentialsId: 'ut-israel-devops',
                        url: 'https://github.com/PerionNet/perion-automation.git'
                    )
                }
            }
        }
//        stage('Restart Mock Server'){
//            steps{
//                dir('perion-automation'){
//                    sh '''#!/bin/bash
//                        sudo ssh -o StrictHostKeyChecking=no -t -i pems/undertone-dev.pem ubuntu@auto-mock.ramp-ut.io "cd ./mock_server/codefuel-sdmg-mock; pwd; sudo git pull https://'codefuel-automation':'codefuel-automation1$'@github.com/PerionNet/codefuel-sdmg-mock.git master"
//                        sudo ssh -o StrictHostKeyChecking=no -t -i pems/undertone-dev.pem ubuntu@auto-mock.ramp-ut.io "sudo service mockserver restart"
//                        sudo ssh -o StrictHostKeyChecking=no -t -i pems/undertone-dev.pem ubuntu@auto-mock.ramp-ut.io "sudo service mockserver1 restart"
//                        sudo ssh -o StrictHostKeyChecking=no -t -i pems/undertone-dev.pem ubuntu@auto-mock.ramp-ut.io "sudo service mockserver2 restart"
//                        sudo ssh -o StrictHostKeyChecking=no -t -i pems/undertone-dev.pem ubuntu@auto-mock.ramp-ut.io "sudo service mockserver3 restart"
//                        sudo ssh -o StrictHostKeyChecking=no -t -i pems/undertone-dev.pem ubuntu@auto-mock.ramp-ut.io "sudo service hubmockserver restart"
//                    '''
//                }
//            }
//        }
        stage('Create Entities') {
            steps {
                script {
                    try {
                        sh '''#!/bin/bash
                        if [ ${CREATE_ENTITIES} = 'true' ]; then
                        docker build -t ${ENVIRONMENT}-entities-${BUILD_NUMBER} . --build-arg TAGS_TO_RUN=@preconditions --build-arg ENVIRONMENT=${ENVIRONMENT}
                        docker create --name temporary-container-${ENVIRONMENT}-entities-${BUILD_NUMBER} ${ENVIRONMENT}-entities-${BUILD_NUMBER}
                        docker cp temporary-container-${ENVIRONMENT}-entities-${BUILD_NUMBER}:/ramp-lift-automation/target/ ./entities/
                        docker rm temporary-container-${ENVIRONMENT}-entities-${BUILD_NUMBER}
                        docker rmi ${ENVIRONMENT}-entities-${BUILD_NUMBER}
                        fi'''
                    } catch (exc) {
                        currentBuild.currentResult = 'FAILURE'
                        throw new Exception("Error creating entities!")
                    }
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    try {
                        sh 'docker build -m 2g -t ${ENVIRONMENT}-suite-${BUILD_NUMBER} . --build-arg TAGS_TO_RUN=${TAGS_TO_RUN} --build-arg SUITE_NAME=${SUITE_NAME} --build-arg ENVIRONMENT=${ENVIRONMENT}'
                        sh 'docker create --name temporary-container-${ENVIRONMENT}-suite-${BUILD_NUMBER} ${ENVIRONMENT}-suite-${BUILD_NUMBER}'
                        sh 'docker cp temporary-container-${ENVIRONMENT}-suite-${BUILD_NUMBER}:/ramp-lift-automation/target/ ./target/'
                        sh '''#!/bin/bash
                            if [ ${CREATE_ENTITIES} = 'true' ]; then
                            rsync -a ./entities/ ./target/
                            fi'''
                        sh 'docker rm temporary-container-${ENVIRONMENT}-suite-${BUILD_NUMBER}'
                        sh 'docker rmi ${ENVIRONMENT}-suite-${BUILD_NUMBER}'
                    } catch (exc) {
                        currentBuild.currentResult = 'FAILURE'
                        throw new Exception(exc)
                    }
                }
            }
        }
        stage('Publish') {
            steps {
                sh '''#!/bin/bash
                    if [ ${JIRA_REPORT} = 'true' ]; then
                    for f in ./target/surefire-reports/*.xml; do
                    curl -H "Content-Type: multipart/form-data" -u jiraservice:!qaz2wsX -F "file=@$f" "https://dev.perion.com/rest/raven/1.0/import/execution/junit?projectKey=Undertone&testExecKey=${TEST_EXEC_KEY}&revision=v1.0.0&testEnvironments=${ENVIRONMENT}"
                    done
                    fi'''
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
        changed {
            script {
                if (currentBuild.currentResult == 'FAILURE') { // Other values: SUCCESS, UNSTABLE
                    // Send an email only if the build status has changed from green/unstable to red
                    emailext subject: '$DEFAULT_SUBJECT',
                            body: '$DEFAULT_CONTENT',
                            recipientProviders: [
                                    [$class: 'CulpritsRecipientProvider'],
                                    [$class: 'DevelopersRecipientProvider'],
                                    [$class: 'RequesterRecipientProvider']
                            ],
                            replyTo: '$DEFAULT_REPLYTO',
                            to: '$DEFAULT_RECIPIENTS'
                }
            }
        }
        cleanup {
            cleanWs()
        }
    }
}