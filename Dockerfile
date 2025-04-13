# Step 1: Use Maven to build the app
FROM maven:3.8.6-jdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY . .

# Step 2: Build the app using Maven
RUN mvn clean install

# Step 3: Run the app (use the JAR file generated in the target directory)
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the 'build' stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port your application will run on
EXPOSE 8080

# Start the application
CMD ["java", "-jar", "app.jar"]
