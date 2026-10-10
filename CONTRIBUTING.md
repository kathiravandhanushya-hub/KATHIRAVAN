# Contributing to KathiravanMart

Thank you for contributing to **KathiravanMart**! This document provides the complete developer onboarding workflow from `git clone` to a running local instance.

---

## Prerequisites

Before starting, ensure your local workstation has the following installed:
- **Java Development Kit (JDK)**: Version 17 (LTS)
- **Apache Maven**: Version 3.8+ (`mvn -version`)
- **Git**: Version 2.30+ (`git --version`)
- **Apache Tomcat**: Version 9.0.x (Servlet 4.0 specification)

---

## Quickstart Guide

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/kathiravanmart.git
cd kathiravanmart
```

### 2. Configure Environment Variables
Copy the template configuration files:
```bash
# On Linux / macOS
cp .env.example .env
cp src/main/resources/config.properties.example src/main/resources/config.properties

# On Windows PowerShell
Copy-Item .env.example .env
Copy-Item src/main/resources/config.properties.example src/main/resources/config.properties
```

The defaults use embedded H2 with `AUTO_SERVER=TRUE`, so no external database installation is required for local development.

### 3. Build and Run Automated Tests
Execute the Maven build and test verification:
```bash
mvn clean test
```
All unit tests and embedded H2 DAO tests will execute and pass.

### 4. Package the Application (.war)
```bash
mvn clean package
```
The packaged artifact `target/kathiravanmart.war` will be generated.

### 5. Deploy to Apache Tomcat 9.0.x
Copy the generated WAR file into Tomcat's `webapps/` folder:
```bash
# Example on Windows:
Copy-Item target/kathiravanmart.war "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\"

# Example on Linux:
cp target/kathiravanmart.war /opt/tomcat/webapps/
```

Start Tomcat and open your browser:
```
http://localhost:8080/kathiravanmart/
```

---

## Branching & Commit Guidelines

1. **Branch Model**: `main` is always production-ready and deployable.
2. Develop new features on separate branches:
   ```bash
   git checkout -b feature/<feature-name>
   ```
3. **Commit Messages**: Use Conventional Commits:
   - `feat: add AI chatbot proxy and rate limiter`
   - `fix: resolve cart total scale rounding`
   - `test: add order service test coverage`
   - `docs: update setup and architecture diagram`

---

## Code Quality Standards

Before submitting a Pull Request, verify:
- Code compiles without major Checkstyle or SpotBugs warnings:
  ```bash
  mvn checkstyle:check
  mvn spotbugs:check
  ```
- All unit and integration tests pass:
  ```bash
  mvn test
  ```
