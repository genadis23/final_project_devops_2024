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
