# Используем базовый образ OpenJDK для сборки
FROM eclipse-temurin:17-jdk-focal as build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем pom.xml и скачиваем зависимости Maven. Это позволяет кэшировать слои Maven.
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Копируем остальной код проекта
COPY src ./src

# Собираем приложение
RUN mvn package -DskipTests

# Используем облегченный образ OpenJDK для запуска приложения
FROM eclipse-temurin:17-jre-focal

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем собранный JAR-файл из промежуточного образа
COPY --from=build /app/target/*.jar app.jar

# Определяем точку входа для запуска приложения
ENTRYPOINT ["java","-jar","app.jar"]
