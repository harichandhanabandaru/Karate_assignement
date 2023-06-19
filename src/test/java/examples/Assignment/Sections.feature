Feature: Todoist API Testing assignment for "Sections"  section

  Background:
    * url 'https://api.todoist.com/rest/v2'
    * header Authorization = 'Bearer eda5ea58ba9befd9d42298a9fb8c405e3c2d7d8d'


#Get all sections
  Scenario: Get all sections
    Given path 'sections'
    And params { project_id: '2314680684' }
    When method GET
    Then status 200
    Then match response == '#array'

#Create a new section
  Scenario: Create a new sections
    Given path 'sections'
    And request '{"project_id":2314680684, "name":"Groceries"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    Then def expectedResponse =
        """
        {
        "id": "#ignore",
            "project_id": "2314680684",
            "order": "#ignore",
            "name": "Groceries"
        }
        """
    Then match response == expectedResponse
    * print response


#Get a single section
  Scenario: Get a single section
    Given path '/sections/126324493'
    When method GET
    Then status 200
    Then def expectedResponse =
          """
          {
          		"id": "126324493",
          		"project_id": "2314680684",
          		"order": 1,
          		"name": "Routines 🔁"
          	}
          """
    Then match response == expectedResponse
    * print response

#Update a section
  Scenario: Update a section
    Given path '/sections/126324493'
    And  request '{"name":"Supermarket"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200

# Deleting a section
  Scenario: Delete a section
    Given path 'sections/2314681382'
    When method DELETE
    Then status 204



