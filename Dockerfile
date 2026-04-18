FROM maven:3.9.9-eclipse-temurin-17 as build
WORKDIR /app
COPY . .
RUN mvn clean install


FROM tomcat:9.0-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
WORKDIR /usr/local/tomcat/webapps/
COPY --from=build /app/target/*.war ./loginwebapp.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

