# Step 1: Use Maven to build the app
FROM maven:3.8.6-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install

# Step 2: Use JDK to run the app
FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Start your app
CMD ["java", "-jar", "app.jar"]
