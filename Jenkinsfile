pipeline {
    agent {
        node {
            label 'slave-vm'
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
        string(name: 'EXTNETUUIDNAME',
            defaultValue: 'external_network_uuid',
            description: 'the provider network' )
        booleanParam(name: 'CLEANUP',
            defaultValue: false,
            description: 'delete OpenStack instances after job is finished')
    }

    stages {
        stage('make variables file') {
            steps {
                script {
                    sh "echo ${params.PUBKEY} > pubkey"
                    sh "sed -i 's/image\\ FIXME/${params.IMAGENAME}/' variables.tf"
                    sh "sed -i 's/external-network-uuid\\ FIXME/${params.EXTNETUUIDNAME}/' variables.tf"
                }
            }
        }

        stage('make a ready to use terraform') {
            steps {
                script {
                    //sh 'wget https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_linux_amd64.zip && unzip terraform_0.14.0_linux_amd64.zip -d /usr/local/bin'
                    sh 'terraform version'
                    //sh 'mc cp hanu-minio/openstack/clouds.yaml .'
                    sh 'cp /root/clouds.yaml .'
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
                if ( params.CLEANUP == true ) {
                    sh 'terraform destroy --auto-approve'
                } else {
                    echo "The environment that made by terraform remained."
                }
            }
        }
    }
}
