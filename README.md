# Gherkin Automation

This repository contains a small Karate setup demonstrating automated acceptance tests. The first business case covers user login functionality.

## Business Requirements

* Users must be able to log in with an email and password.
* Successful login redirects the user to the dashboard.
* An informative error is shown when login fails.
* After five consecutive failed attempts, the account becomes locked.
* Accounts must be verified before login is permitted.

## Running Tests with Karate

This project includes a Maven configuration and a JUnit runner. To execute the scenarios simply run:

```bash
mvn test
```

The login feature uses a `Scenario Outline` and a loop implemented with `karate.forEach` to demonstrate iterations in Gherkin.
