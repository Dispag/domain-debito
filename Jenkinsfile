
   
def apps = [
  stage: [
    
  ],
  production: [
    
  ]
]

pipeline {
  agent any
  parameters {
    choice(name: 'ACTION',
     choices: ['deploy', 'down'],
     description: 'Which action to do ?')
  }
  environment {
    ACTION = "${params.ACTION}"
    DOCKER_SERVER_IP = "10.11.2.195"
	SERVER_NAT_ID = "i-0b904b2b65635f1db"
  }

  stages {
    stage('Prepare') {
      steps { 
         
          sh '''echo env: ${ACTION}
          	sudo su
			aws ec2 start-instances --region us-east-2 --instance-ids ${SERVER_NAT_ID}
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'rm -f -r /home/ec2-user/deployments/*'
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'cd /home/ec2-user/deployments/ && git clone https://github.com/Dispag/domain-debito.git'
			ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'cd /home/ec2-user/deployments/domain-debito && make down'
          '''
        
      }
    }
    
    stage('Build') {
	  when {
        expression {
          params.ACTION == 'deploy'
        }
      }
      steps { 
         
          sh '''echo env: ${ACTION}
          	sudo su
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'cd /home/ec2-user/deployments/domain-debito && make build'
          
          '''
        
      }
    }

	stage('Deploy') {
	  when {
        expression {
          params.ACTION == 'deploy'
        }
      }
      steps { 
         
          sh '''echo env: ${ACTION}
          	sudo su
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'cd /home/ec2-user/deployments/domain-debito && make run'
          
          '''
        
      }
    }
	
	stage('Down') {
	  when {
        expression {
          params.ACTION == 'down'
        }
      }
      steps { 
         
          sh '''echo env: ${ACTION}
          	sudo su
          	ssh -i /home/ec2-user/access/alexsanderhage.pem ec2-user@${DOCKER_SERVER_IP} 'cd /home/ec2-user/deployments/domain-debito && make down'
          
          '''
        
      }
    }
   
  }
}
