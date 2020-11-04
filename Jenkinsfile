pipeline {
    agent {
        node {
            label 'openstack-slave'
            customWorkspace "workspace/${env.JOB_NAME}/${env.BUILD_NUMBER}"
        }
    }

    stages {
        stage('make a ready to use terraform') {
            steps {
                sh 'terraform version'
                sh 'mc cp hanu-minio/openstack/clouds.yaml .'
                sh 'terraform init'
                echo 'done'
            }
        }
    }
}
