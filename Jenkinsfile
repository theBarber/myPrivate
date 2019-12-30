pipeline {
    agent any
    stages {
        stage('Create Entities') {
            steps {
                script {
                    try {
                        sh '''#!/bin/bash
                    if [ ${CREATE_ENTITIES} = 'true' ]; then
                    docker build -t ${ENVIRONMENT}-entities-${BUILD_NUMBER} . --build-arg TAGS_TO_RUN=@preconditions --build-arg ENVIRONMENT=${ENVIRONMENT}
                    docker create --name temporary-entities-container ${ENVIRONMENT}-entities-${BUILD_NUMBER}
                    docker cp temporary-entities-container:/target/ ./entities/
                    docker rm temporary-entities-container
                    docker rmi ${ENVIRONMENT}-entities-${BUILD_NUMBER}
                    fi'''
                    } catch (exc) {
                        throw new Exception("Error creating entities!")
                    }
                }
            }
        }
        stage('Test') {
            steps {
                sh 'docker build -t ${ENVIRONMENT}-suite-${BUILD_NUMBER} . --build-arg TAGS_TO_RUN=${TAGS_TO_RUN} --build-arg SUITE_NAME=${SUITE_NAME} --build-arg ENVIRONMENT=${ENVIRONMENT}'
                sh 'docker create --name temporary-container ${ENVIRONMENT}-suite-${BUILD_NUMBER}'
                sh 'docker cp temporary-container:/target/ ./target/'
                sh '''#!/bin/bash
                    if [ ${CREATE_ENTITIES} = 'true' ]; then
                    rsync -a ./entities/ ./target/
                    fi'''
                sh 'docker rm temporary-container'
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