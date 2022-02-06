# the first stage of our build will use a maven 3.6.1 parent image
FROM maven:3.6.3-openjdk-14 AS MAVEN_BUILD

# copy the pom and src code to the container
COPY ./ ./
 
# package our application codedocker 
RUN mvn clean package
RUN pwd

FROM openjdk:14

WORKDIR /usr/src/app  


# copy only the artifacts we need from the first stage and discard the rest
COPY --from=MAVEN_BUILD target/domain-debito-2.6.3.jar /domain-debito.jar

RUN yum update && \
    yum install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        groff \
        less \
    && pip3 install --upgrade pip \
    && yum clean

RUN pip3 --no-cache-dir install --upgrade awscli

RUN echo  aws ssm get-parameters --name DISPAG_DATASOURCE_USERNAME --region us-east-2 --output text --query Parameters[].Value
 

##Kafka Config
ENV KAFKA_SERVER=localhost:29092
ENV KAFKA_GROUP=DISPAG
ENV KAFKA_CONSUMER_REGISTRAR_DEBITO_TOPIC=REGISTRARDEBITO
ENV KAFKA_PRODUCER_VERIFICAR_CREDOR_TOPIC=VERIFICARCREDOR

##Banco Config
ENV DATASOURCE_URL=jdbc:postgresql://192.168.15.51:5432/tarefas
ENV DATASOURCE_USERNAME=programador
ENV DATASOURCE_PASSWORD=hidros

CMD ["java", "-jar", "-XX:+UseG1GC", "domain-debito.jar"]