FROM maven:3.5.3-jdk-8-alpine as build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests=true

FROM openjdk:8-jre-slim
# RUN adduser -D shoeshop
WORKDIR /run
COPY --from=build /app/target/shoe-ShopingCart-0.0.1-SNAPSHOT.jar /run/shoe-ShopingCart-0.0.1-SNAPSHOT.jar
# RUN chown -R shoeshop:shoeshop /run
# USER shoeshop
EXPOSE 8080
CMD [ "java","-jar","/run/shoe-ShopingCart-0.0.1-SNAPSHOT.jar" ]
