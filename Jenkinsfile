
   
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
    DOCKER-SERVER_IP = '10.11.2.195'
  }

  stages {
    stage('Build') {
      steps { 
         
          sh '''echo env: ${ENVIRONMENT}
          	sudo su
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER-SERVER_IP} 'rm -f -r /home/ec2-user/deployments/*'
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER-SERVER_IP} 'git clone https://github.com/Dispag/domain-debito.git'
          
          
          '''
        
      }
    }

   
  }
}
