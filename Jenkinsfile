pipeline {

    agent {
        node {
            label 'jenkins-node'
        }
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: "10"))
    }

    parameters {
        // choice(name: 'destroy_env', choices: loadChoice("destroy_env"), description: 'Destroy Env (Default: false)')
        // choice(name: 'provider', choices: loadChoice("provider_list"), description: 'Escolha a cloud para deploy (Default: aws)')
        // choice(name: 'terraform_version', choices: loadChoice("terraform_version"), description: 'Terraform Version (Default: 1.0.10)')
        choice(name: 'region', choices: ['us-east-1'], description: 'Region (Default: us-east-1)')
    }

    environment {
        APPLICATION_NAME="poc-jenkins-grafana"
        ENV=""
    }

    stages {
        stage('Approval for productive environments') {
            when {
                anyOf {
                    branch 'master'
                }
            }
            steps {
                script {
                    timeout(time: 1, unit: 'DAYS') {
                        approval(env.GIT_BRANCH, env.GIT_URL)
                    }
                }
            }
        }

        stage('Set Environment') {
            parallel {
                stage('Development') {
                    when {
                        not {
                            anyOf {
                                branch 'master';
                                branch 'staging'
                            }
                        }
                    }

                    steps {
                        script {
                            ENV = "dev"
                        }
                    }
                }

                stage('Staging') {
                    when {
                        branch 'staging'
                    }
                  
                    steps {
                        script {
                            ENV = "stg"
                        }
                    }
                }

                stage('Production') {
                    when {
                        branch 'master'
                    }
                   
                    steps {
                        script {
                            ENV = "prd"
                        }
                    }
                }
            }
        }

        // stage('Install Dependencies') {
        //     steps {
        //         sh "scripts/install-dependencies.sh ${params.terraform_version}"
        //     }
        // }

        // stage('Load Modules'){
        //     steps {
        //         loadModules()
        //     }
        // }

        // stage('Configure Terraform'){
        //     steps {
        //         script{
        //             configureTerraform(APPLICATION_NAME, params.provider, ENV)
        //         }
        //     }
        // }

        // stage('Destroy Environment') {
        //     parallel {
        //         stage('AWS') {
        //             when {
        //                 anyOf {
        //                     expression { params.provider == "aws" && params.destroy_env == "true" }    
        //                 }
        //             }
        //             steps {
        //                 destroyEnv(ENV, params.region, APPLICATION_NAME, MODULES, params.provider)
        //             }
        //         }

        //         stage('Azure') {
        //             when {
        //                 anyOf {
        //                     expression { params.provider == "azure" && params.destroy_env == "true" }
        //                 }
        //             }
        //             steps {
        //                 destroyEnv(ENV, params.region, APPLICATION_NAME, MODULES, params.provider)
        //             }
        //         }
        //     }
        // }
       
        // stage ('Build App') {
        //     when {
        //         expression { 
        //             params.destroy_env == "false"
        //         }
        //     }

        //     steps {
        //         sh "scripts/build-app.sh ${ENV} ${APPLICATION_NAME}"
        //     }
        // }

        // stage(' ') {   
		// 	parallel {   
		// 		stage('AWS') {
		// 			when { 
        //                 allOf {
		// 				    expression { params.provider == "aws" }
        //                     expression { params.destroy_env == "false" }				
        //                 } 
		// 			} 
        //             stages {
        //                 stage('Test IaC') {
        //                     steps {
        //                         script {
        //                             testIac(ENV, params.region, APPLICATION_NAME, MODULES, params.provider)
        //                         }
        //                     }
        //                 }          

        //                 stage('Deploy Environment') {
        //                     steps {
        //                         script {
        //                             deployEnv(ENV, params.region, APPLICATION_NAME, MODULES, params.provider)
        //                         }
        //                     }
        //                 }

        //                 stage('Deploy App') {
        //                     steps {
        //                         script {
        //                             deployAppServerless(ENV, params.provider)
        //                         }
        //                     }
        //                 }
        //             }
        //         }

        //         stage('Azure') {
		// 			when { 
        //                 allOf {
		// 				    expression { params.provider == "azure" }
        //                     expression { params.destroy_env == "false" }				
        //                 } 
		// 			}
        //             stages {
        //                 stage('Test IaC') {
        //                     steps {
        //                         script {
        //                             echo "rodando TestIaC Azure..."
        //                         }
        //                     }
        //                 }          

        //                 stage('Deploy Environment') {
        //                     steps {
        //                         script {
        //                             echo "rodando DeployEnv Azure..."
        //                         }
        //                     }
        //                 }

        //                 stage('Deploy App') {
        //                     steps {
        //                         script {
        //                             echo "rodando DeployApp Azure..."
        //                         }
        //                     }
        //                 }
        //             }
        //         }
        //     }
        // }
    }
}
