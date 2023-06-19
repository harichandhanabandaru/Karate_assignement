Feature: Todoist API Testing assignment for labels section

  Background:
    * url 'https://api.todoist.com/rest/v2'
    * header Authorization = 'Bearer eda5ea58ba9befd9d42298a9fb8c405e3c2d7d8d'
    * def uuid = java.util.UUID.randomUUID().toString()


#Get all Labels
  Scenario: Get all comments
    Given path 'labels'
    When method GET
    Then status 200
    Then assert responseStatus == 200


#Create a new label
  Scenario: Create a new label
    Given path 'labels'
    And request
    """
    {"name": "Food2"}
    """
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    Then def expectedResponse =
        """{
            "id": "#ignore",
            "name": "Food2",
            "order": "#ignore",
            "color": "charcoal",
            "is_favorite": false
          }
        """
    Then match response == expectedResponse
    * print response


#Get a label
  Scenario: Get a label
    Given path '/labels/2167266423'
    When method GET
    Then status 200
    Then def expectedResponse =
          """
      {
              "id": "2167266423",
              "name": "read",
              "order": 1,
              "color": "charcoal",
              "is_favorite": false
          }
          """
    Then match response == expectedResponse
    * print response

#Update a label
  Scenario: Update a label
    Given path '/labels/2167300758'
    And  request '{"name": "Food"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200



# Delete a label
  Scenario: Delete a label
    Given path '/labels/2167300777'
    When method DELETE
    Then status 204




