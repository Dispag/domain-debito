
   
def apps = [
  stage: [
    
  ],
  production: [
    
  ]
]

pipeline {
  agent any
  parameters {
    choice(name: 'ENVIRONMENT',
     choices: ['none', 'stage', 'production'],
     description: 'Which environment to deploy ?')
    booleanParam (defaultValue: true, name: 'RUN_TESTS', description: 'Run Tests?')
  }
  environment {
    ENVIRONMENT = "${params.ENVIRONMENT}"
    DOCKER_SERVER_IP = "10.11.2.195"
  }

  stages {
    stage('Prepare') {
      steps { 
         
          sh '''echo env: ${ENVIRONMENT}
          	sudo su
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'rm -f -r /home/ec2-user/deployments/*'
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'cd /home/ec2-user/deployments/ && git clone https://github.com/Dispag/domain-debito.git'
          
          '''
        
      }
    }
    
    stage('Build') {
      steps { 
         
          sh '''echo env: ${ENVIRONMENT}
          	sudo su
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'cd /home/ec2-user/deployments/domain-debito && make build'
          
          '''
        
      }
    }

	 stage('Deploy') {
      steps { 
         
          sh '''echo env: ${ENVIRONMENT}
          	sudo su
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'cd /home/ec2-user/deployments/domain-debito && make run'
          
          '''
        
      }
    }
   
  }
}
