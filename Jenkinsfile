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
        stage('Create Entities') {
            steps {
                script {
                    try {
                        sh '''#!/bin/bash
                        if [ ${CREATE_ENTITIES} = 'true' ]; then
                        docker build -t ${ENVIRONMENT}-entities-${BUILD_NUMBER} . --build-arg TAGS_TO_RUN=@preconditions --build-arg ENVIRONMENT=${ENVIRONMENT}
                        docker create --name temporary-entities-container ${ENVIRONMENT}-entities-${BUILD_NUMBER}
                        docker cp temporary-entities-container:/target/ ./entities/
                        fi'''
                    } catch (exc) {
                        throw new Exception("Error creating entities!")
                    } finally {
                        sh '''#!/bin/bash
                        docker rm temporary-entities-container-${BUILD_NUMBER}
                        docker rmi ${ENVIRONMENT}-entities-${BUILD_NUMBER}
                        '''
                    }
                }
            }
        }
        stage('Test') {
            steps {
                sh 'docker build -t ${ENVIRONMENT}-suite-${BUILD_NUMBER} . --build-arg TAGS_TO_RUN=${TAGS_TO_RUN} --build-arg SUITE_NAME=${SUITE_NAME} --build-arg ENVIRONMENT=${ENVIRONMENT}'
                sh 'docker create --name temporary-container-${BUILD_NUMBER} ${ENVIRONMENT}-suite-${BUILD_NUMBER}'
                sh 'docker cp temporary-container-${BUILD_NUMBER}:/target/ ./target/'
                sh '''#!/bin/bash
                    if [ ${CREATE_ENTITIES} = 'true' ]; then
                    rsync -a ./entities/ ./target/
                    fi'''
                sh 'docker rm temporary-container-${BUILD_NUMBER}'
                sh 'docker rmi ${ENVIRONMENT}-suite-${BUILD_NUMBER}'
            }
        }
        stage('Publish') {
            steps {
                sh '''#!/bin/bash
                    if [ ${JIRA_REPORT} = 'true' ]; then
                    for f in ./ramp-ui-automation/target/surefire-reports/junitreports/*.xml; do
                    curl -H "Content-Type: multipart/form-data" -u jiraservice:!qaz2wsX -F "file=@$f" "https://dev.perion.com/rest/raven/1.0/import/execution/junit?projectKey=Undertone&testExecKey=${TEST_EXEC_KEY}&revision=v1.0.0&testEnvironments=${ENVIRONMENT}"
                    done
                    fi'''
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
            cleanWs()
        }
    }
}