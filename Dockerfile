FROM openjdk:8-jdk-alpine 
COPY . /var/www/java  
WORKDIR /var/www/java  
RUN java -jar target/HelloWorld-1.0-SNAPSHOT.jar  
