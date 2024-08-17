pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/genadis23/final_project_devops_2024.git'
            }
        }
        
        stage('Check Changes') {
            steps {
                script {
                    def changes = getChanges()
                    if (changes) {
                        echo "Changes detected:"
                        echo changes
                        emailext body: "The following changes were detected in the repository:\n\n${changes}", 
                                 subject: "Jenkins detect changes in github", 
                                 to: "genadis23@gmail.com"
                    } else {
                        echo "No changes detected"
                    }
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

def getChanges() {
    def changeLog = ""
    def changeLogSets = currentBuild.changeSets
    for (int i = 0; i < changeLogSets.size(); i++) {
        def entries = changeLogSets[i].items
        for (int j = 0; j < entries.length; j++) {
            def entry = entries[j]
            changeLog += "- ${entry.msg} [${entry.author}]\n"
        }
    }
    return changeLog
}
