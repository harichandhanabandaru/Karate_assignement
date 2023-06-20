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
    * def labelId = response.id
    And karate.write(labelId, 'labelId.txt')
    * print response


#Get a label
  Scenario: Get a label
    * def id = read("file:target/labelId.txt")
    Given path '/labels/'+id
    When method GET
    Then status 200
    Then def expectedResponse =
          """
      {
              "id": "#(id)",
              "name": "Food2",
              "order": "#ignore",
              "color": "charcoal",
              "is_favorite": false
          }
          """
    Then match response == expectedResponse
    * print response

#Update a label
  Scenario: Update a label
    * def id = read("file:target/labelId.txt")
    Given path '/labels/'+id
    And  request '{"name": "Food"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200

# Delete a label
  Scenario: Delete a label
    * def id = read("file:target/labelId.txt")
    Given path '/labels/'+id
    When method DELETE
    Then status 204




