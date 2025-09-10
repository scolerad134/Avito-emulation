# Avito Emulation Project

## Обзор

Этот проект представляет собой эмуляцию популярного сервиса объявлений Avito, разработанную с использованием Spring Boot. Он демонстрирует основные функции, такие как управление объявлениями, пользователями и интеграцию с базой данных PostgreSQL.

## Возможности (Примеры, можно дополнить)

*   Создание, просмотр, редактирование и удаление объявлений.
*   Регистрация и аутентификация пользователей.
*   Просмотр списка объявлений.

## Используемые технологии

*   **Spring Boot**: Фреймворк для быстрой разработки Spring-приложений.
*   **Maven**: Инструмент для автоматизации сборки проектов.
*   **PostgreSQL**: Реляционная система управления базами данных.
*   **Liquibase**: Инструмент для управления изменениями в схеме базы данных.
*   **FreeMarker**: Шаблонизатор для генерации HTML-страниц.
*   **Docker / Docker Compose**: Для контейнеризации приложения и базы данных.

## Предварительные требования

Для запуска проекта на вашей локальной машине убедитесь, что у вас установлено следующее программное обеспечение:

*   **Java Development Kit (JDK) 17+**
*   **Apache Maven 3.6+**
*   **Docker и Docker Compose** (рекомендуется для простой настройки)
*   **PostgreSQL 14+** (если вы не используете Docker Compose для базы данных)

## Настройка проекта

### 1. Клонирование репозитория

```bash
git clone https://github.com/scolerad134/Avito-emulation.git
cd Avito-emulation
```

### 2. Настройка PostgreSQL (ТОЛЬКО если НЕ используете Docker Compose для базы данных)

Если вы планируете запускать базу данных PostgreSQL отдельно (без Docker Compose), вам необходимо создать пользователя базы данных и саму базу данных для проекта. Если вы используете Docker Compose, этот шаг будет выполнен автоматически.

#### Для пользователей Ubuntu/Linux:

1.  Переключитесь на пользователя `postgres`:
    ```bash
    sudo -i -u postgres
    ```
2.  Создайте пользователя `avito_owner` и установите пароль:
    ```bash
    createuser avito_owner --pwprompt
    # Введите ваш пароль, например: myPassword
    ```
3.  Создайте базу данных `avito_db` и назначьте `avito_owner` ее владельцем:
    ```bash
    createdb avito_db -O avito_owner
    ```
4.  Выйдите из пользователя `postgres`:
    ```bash
    exit
    ```

#### Для пользователей Windows:

1.  Откройте **SQL Shell (psql)** из меню "Пуск".
2.  Подключитесь к системной базе данных `postgres` как пользователь `postgres` (используя пароль, который вы установили при установке PostgreSQL).
    *   Server: `localhost`
    *   Database: `postgres`
    *   Port: `5432`
    *   Username: `postgres`
    *   Password: `[пароль_пользователя_postgres]`
3.  Выполните следующие команды в psql. **Замените `myPassword` на ваш желаемый пароль для `avito_owner`.**
    ```sql
    CREATE USER avito_owner WITH PASSWORD 'myPassword';
    CREATE DATABASE avito_db OWNER avito_owner;
    ```
4.  Введите `\q` для выхода из psql.

### 3. Конфигурация приложения

1.  Откройте файл `src/main/resources/application.properties`.
2.  Обновите значения `spring.datasource.username` и `spring.datasource.password` в соответствии с пользователем (`avito_owner`) и паролем, который вы установили.

    Пример `application.properties` (если вы запускаете базу данных отдельно):

    ```properties
    spring.datasource.url=jdbc:postgresql://localhost:5432/avito_db?useSSL=false&serverTimezone=UTC
    spring.datasource.username=avito_owner
    spring.datasource.password=myPassword
    spring.jpa.hibernate.ddl-auto=update
    spring.jpa.show-sql=true
    spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
    spring.liquibase.change-log=classpath:db/changelog/db.changelog-master.yaml
    spring.freemarker.expose-request-attributes=true
    ```
    **Важно:** Убедитесь, что `spring.datasource.password` содержит **тот же пароль**, который вы использовали при создании пользователя `avito_owner`.

    Если вы используете Docker Compose, то параметры подключения к базе данных будут переопределены переменными окружения из `docker-compose.yml`, поэтому в `application.properties` может оставаться дефолтная конфигурация для локальной разработки, но для Docker Compose приоритет будет у переменных окружения.

## Запуск проекта

### Вариант 1: Запуск с Docker Compose (Рекомендуется)

Этот способ наиболее простой, так как он запускает как ваше приложение, так и базу данных PostgreSQL в контейнерах.

1.  Убедитесь, что у вас установлен Docker и Docker Compose.
2.  Перейдите в корневой каталог проекта в терминале.
3.  Соберите образы и запустите контейнеры:
    ```bash
    docker compose up --build
    ```
    При первом запуске Liquibase автоматически применит миграции к базе данных в контейнере. Если вы столкнулись с ошибками "relation already exists", вам, возможно, придется удалить volume базы данных (`docker volume rm <имя_проекта>_avito_db_data`, где `<имя_проекта>` - обычно имя каталога вашего проекта, например `avito-emulation_avito_db_data`) перед повторным запуском `docker-compose up --build`, чтобы дать Liquibase чистую базу данных.

Ваше приложение будет доступно по адресу `http://localhost:8080`.

### Вариант 2: Запуск без Docker (Вручную)

Если вы не используете Docker Compose, следуйте этим шагам:

1.  Убедитесь, что ваша база данных PostgreSQL настроена как описано в разделе "Настройка PostgreSQL", и файл `application.properties` правильно сконфигурирован.
2.  Перейдите в корневой каталог проекта в терминале.
3.  Соберите проект:
    ```bash
    mvn clean package
    ```
4.  Запустите приложение:
    ```bash
    java -jar target/Avito-emulation-0.0.1-SNAPSHOT.jar
    ```
    (Имя JAR-файла может отличаться в зависимости от версии.)

Приложение будет доступно по адресу `http://localhost:8080` (если не настроен другой порт).

## Тестирование

Для запуска всех тестов выполните:
```bash
mvn test
```
