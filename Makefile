PROJECT=domaindebito


DATASOURCE_URL=$(shell  aws ssm get-parameters --name /dispag/database/datasourceurl --region us-east-2 --output text --query Parameters[].Value)
DATASOURCE_USERNAME=$(shell  aws ssm get-parameters --name /dispag/database/username --region us-east-2 --output text --query Parameters[].Value)
DATASOURCE_PASSWORD=$(shell  aws ssm get-parameters --name /dispag/database/password --region us-east-2 --output text --query Parameters[].Value)
KAFKA_SERVER=$(shell  aws ssm get-parameters --name /dispag/kafka/server --region us-east-2 --output text --query Parameters[].Value)


build: 
	docker-compose -f docker-compose.yml build \
	--build-arg DATASOURCE_URL=$(DATASOURCE_URL) \
	--build-arg DATASOURCE_USERNAME=$(DATASOURCE_USERNAME) \
	--build-arg DATASOURCE_PASSWORD=$(DATASOURCE_PASSWORD)	\
	--build-arg KAFKA_SERVER=$(KAFKA_SERVER)
	
run: 
	docker-compose run \
	-e DATASOURCE_URL=$(DATASOURCE_URL) \
	-e DATASOURCE_USERNAME=$(DATASOURCE_USERNAME) \
	-e DATASOURCE_PASSWORDD=$(DATASOURCE_PASSWORD) \
	-e KAFKA_SERVER=$(KAFKA_SERVER) \
	$(PROJECT)
	
down:
	docker-compose down --remove-orphans