FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -Pprod -DskipTests clean package

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/storybot-prod.jar /app/app.jar
EXPOSE 10000
ENTRYPOINT ["sh","-c","java -jar /app/app.jar --spring.profiles.active=prod --server.port=${PORT:-10000}"]
