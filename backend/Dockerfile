# Use OpenJDK 22 as the base image
FROM openjdk:22-jre-slim

# Set the working directory
WORKDIR /app

# Copy the jar file produced by Maven build
COPY target/backend.jar backend.jar

# Expose the port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "backend.jar"]

