FROM maven:3.8.4-openjdk-11 AS build

WORKDIR /app

COPY app/pom.xml .

COPY app/src ./src

RUN mvn clean package

FROM tomcat:10.0-jdk11

COPY --from=build /app/target/main-app-1.0.0.war /usr/local/tomcat/webapps/ROOT.war

RUN sed -i 's/port="8080"/port="8000"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8000

CMD ["catalina.sh", "run"]
