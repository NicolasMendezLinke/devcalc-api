FROM maven:3.9.6-eclipse-temurin-17 AS build

# diretório dentro do container
WORKDIR /app

# copiar o projeto inteiro
COPY . .

# rodar testes
RUN mvn clean test

# gerar o jar (caso os testes tenham passado)
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
