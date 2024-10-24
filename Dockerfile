FROM maven:3.8.7-openjdk-18-slim AS build

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn clean package -DskipTests

#etapa 2, utilizar el compilado
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 5000

ENTRYPOINT [ "java", "-jar", "/app/app.jar" ]

