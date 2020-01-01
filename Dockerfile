FROM java:8  
COPY . /var/www/java  
WORKDIR /var/www/java  
RUN java -jar target/hello-world-0.0.1-SNAPSHOT.jar  
