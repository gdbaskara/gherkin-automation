Feature: User login
  As a registered user
  I want to authenticate with my account
  So that I can access protected areas of the site

  Background:
    * url baseUrl
    * path 'login'
    * header Content-Type = 'application/json'

  Scenario: Successful login with valid credentials
    Given request { email: 'user@example.com', password: 'CorrectHorseBatteryStaple' }
    When method post
    Then status 200
    And match response.token == '#string'

  Scenario Outline: Login fails with invalid credentials
    Given request { email: '<email>', password: '<password>' }
    When method post
    Then status 401

    Examples:
      | email               | password        |
      | user@example.com    | wrongPassword   |
      | unknown@example.com | correctPassword |
      |                     | correctPassword |
      | user@example.com    |                 |
      | USER@example.com    | correctPassword |

  Scenario: Account is locked after too many failed attempts
    * def attempt = { email: 'locked@example.com', password: 'wrongPassword' }
    * repeat 5
      Given request attempt
      When method post
      Then status 401
    Given request { email: 'locked@example.com', password: 'correctPassword' }
    When method post
    Then status 423

  Scenario: Account not verified
    Given request { email: 'pending@example.com', password: 'correctPassword' }
    When method post
    Then status 403

  Scenario: Looping login attempts using a table
    * table creds
      | email              | password |
      | loop1@example.com  | wrong1   |
      | loop2@example.com  | wrong2   |
    * def statuses = []
    * karate.forEach(creds, function(row){
        var result = karate.call({ url: baseUrl + '/login', method: 'post', request: row });
        statuses.push(result.status);
      })
    * match statuses == [401, 401]
