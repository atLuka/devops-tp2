FROM gradle:8.5-jdk21 AS builder
WORKDIR /home/gradle/project
COPY build.gradle settings.gradle ./
COPY src src
RUN gradle build --no-daemon -x test

FROM eclipse-temurin:21-jre
EXPOSE 8080
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
