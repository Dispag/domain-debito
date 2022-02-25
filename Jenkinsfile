
   
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
  }

  stages {
    stage('Build') {
      steps { 
         
          sh '''echo env: ${ENVIRONMENT}
          	sudo su
          	ssh -i access/alexsanderhage.pem ec2-user@10.11.2.195 'docker ps'
          
          
          
          '''
        
      }
    }

   
  }
}
