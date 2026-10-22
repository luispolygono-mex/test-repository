# Stage 1: Build JAR using Temurin JDK 21 and Maven
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app

# Copy Maven wrapper and POM first (to cache dependencies)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

# Copy source code and build production JAR
COPY src src
RUN ./mvnw package -DskipTests -B

# Stage 2: Minimal Runtime JRE 21
FROM eclipse-temurin:21-jre-alpine AS runner
WORKDIR /app

# Create non-root user for security
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy built JAR from builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]