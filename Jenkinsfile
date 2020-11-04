pipeline {
    agent {
        node {
            label 'openstack-slave'
            customWorkspace "workspace/${env.JOB_NAME}/${env.BUILD_NUMBER}"
        }
    }

    parameters {
        string(name: 'PUBKEY',
            defaultValue: 'ssh-key xxxxx',
            description: 'ssh public key (ex. ~/.ssh/id_rsa.pub)')
        string(name: 'IMAGENAME',
            defaultValue: 'centos7',
            description: 'openstack image name that is already uploaded' )
        string(name: 'EXTNET-NAME',
            defaultValue: 'external_network',
            description: 'the provider network' )
        string(name: 'NATNET-NAME',
            defaultValue: 'internal_network',
            description: 'the network that can access internet via provider network' )
        booleanParam(name: 'CLEANUP',
            defaultValue: false,
            description: 'delete OpenStack instances after job is finished')
    }

    stages {
        stage('make variables file') {
            steps {
                script {
                    sh "echo ${params.PUBKEY} > pubkey"
                    sh "sed -i 's/centos\\ FIXME/${params.IMAGENAME}/' 9-variables.tf"
                    sh "sed -i 's/external-network\\ FIXME/${params.EXTNET-NAME}/' 9-variables.tf"
                    sh "sed -i 's/internal-network\\ FIXME/${params.NATNET-NAME}/' 9-variables.tf"
                }
            }
        }

        stage('make a ready to use terraform') {
            steps {
                script {
                    sh 'terraform version'
                    sh 'mc cp hanu-minio/openstack/clouds.yaml .'
                    sh 'terraform init'
                    echo 'done'
                }
            }
        }

        stage('make a env') {
            steps {
                script {
                    sh 'terraform plan'
                    sh 'terraform apply --auto-approve'
                }
            }
        }
    }

    post {
        always {
            script {
                if ( param.CLEANUP == true ) {
                    sh 'terraform destroy --auto-approve'
                }
            }
        }
    }
}
