
prepare:
	DATASOURCE_URL=$(shell  aws ssm get-parameters --name /dispag/database/datasourceurl --region us-east-2 --output text --query Parameters[].Value)
	DATASOURCE_USERNAME=$(shell  aws ssm get-parameters --name /dispag/database/username --region us-east-2 --output text --query Parameters[].Value)
	DATASOURCE_PASSWORD=$(shell  aws ssm get-parameters --name /dispag/database/password --region us-east-2 --output text --query Parameters[].Value)
	KAFKA_SERVER=$(shell  aws ssm get-parameters --name /dispag/kafka/server --region us-east-2 --output text --query Parameters[].Value)
	docker rm  $(docker container ps -a -q)
	docker rmi -f $(docker images -a -q)
	@echo "URL: $(DATASOURCE_URL)"

build: prepare
	docker-compose -f docker-compose.yml build \
	--build-arg DATASOURCE_URL \
	--build-arg DATASOURCE_USERNAME \
	--build-arg DATASOURCE_PASSWORD	\
	--build-arg KAFKA_SERVER
	

run: prepare
	docker-compose -f docker-compose.yml build \
	--build-arg DATASOURCE_URL \
	--build-arg DATASOURCE_USERNAME \
	--build-arg DATASOURCE_PASSWORD \
	--build-arg KAFKA_SERVER