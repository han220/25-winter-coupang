# BUILD
FROM maven:3.8.4-openjdk-11 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean install -DskipTests

# Run
FROM tomcat:9.0

WORKDIR /usr/local/tomcat/webapps

COPY --from=build /app/target/CoupangSpring.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

# 도커파일 빌드
# docker build -t spring-tomcat-app .

# 도커파일 실행
# docker run --rm -p 8080:8080 spring-tomcat-app
