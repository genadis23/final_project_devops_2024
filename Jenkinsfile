pipeline {
    agent {
        node {
            label 'agent'
            customWorkspace "./workspace/${JOB_NAME}/$BUILD_NUMBER"
        }
    }
    stages {
        stage("Initialize") {
            steps {
                sh 'make venv'
                withPythonEnv("${env.WORKSPACE}/.venv/bin/python3") {
                    sh 'make install-requirements'
                }
            }
        }
        stage("Lint") {
            steps {
                withPythonEnv("${env.WORKSPACE}/.venv/bin/python3") {
                    sh 'make lint'
                }
            }
        }
        stage("Docker Build") {
            steps {                                
                sh 'make build-image'
                                                
            }
        }
        stage('Docker Push') {
            when {
                anyOf {
                    branch 'main'
                }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh 'make push-image'
                }
            }
        }
    }
    post {
        always {
            notifySlack(
                buildTag: env.BUILD_TAG,
                buildUrl: env.BUILD_URL,
            )
        }
    }
}

def notifySlack(Map notifyParams) {
    script {
        String userName = "genadis23"
        echo "Job status: ${currentBuild?.currentResult}"
        if (currentBuild?.resultIsBetterOrEqualTo('SUCCESS')) {
            ADDED_INFO = "Previous build ${currentBuild?.getPreviousBuild()?.number} failed and now it has been fixed."
            SLACK_MESSAGE = """
            :white_check_mark: Jenkins job ${notifyParams.buildTag} finished successfully! :partying_face:
:link: For more information: ${notifyParams.buildUrl}
:bust_in_silhouette: Author: @${userName.trim()}
:information_source: ${ADDED_INFO}
"""
            NOTIFICATION_COLOR = 'good'
        } else if (currentBuild?.currentResult == 'FAILURE') {
            SLACK_MESSAGE = """
            :x: Jenkins job ${notifyParams.buildTag} Failed! :cry:
:link: For more information: ${notifyParams.buildUrl}
:bust_in_silhouette: Author: @${userName.trim()}
:information_source: Previous build result was ${currentBuild.getPreviousBuild().result}.
"""
            NOTIFICATION_COLOR = 'danger'
        } else {
            SLACK_MESSAGE = """
            :warning: Jenkins job ended with status: ${currentBuild.currentResult}.
:link: For more information: ${notifyParams.buildUrl}
:bust_in_silhouette: Author: @${userName.trim()}
:information_source: Previous build result was: ${currentBuild.getPreviousBuild().result}.
"""

            NOTIFICATION_COLOR = 'warning'
        }
    }
    slackSend channel: "final_project_2024_genadi", message: "${SLACK_MESSAGE}", color: "${NOTIFICATION_COLOR}"
}