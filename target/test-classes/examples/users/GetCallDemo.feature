Feature: Get the details of User 2

  Background: Set url
    * url 'https://reqres.in'

  Scenario:Get the details of User 2
    Given  path "users/2"
    When method GET
    Then status 200

  @debug
  Scenario: Create A Person
    Given path '/api/users'
    And request
    """
    {
    "name": "morpheus",
    "job": "leader"
    }
    """
    When method POST
    Then status 201
    Then match response == "#object"
    Then match response.name == "morpheus"

  Scenario: Get the details of User 2
    Given path "/api/users"
    And param page = "2"
    When method GET
    Then status 200
    Then match response.page == 2