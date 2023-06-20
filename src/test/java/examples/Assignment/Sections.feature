Feature: Todoist API Testing assignment for "Sections"  section

  Background:
    * url 'https://api.todoist.com/rest/v2'
    * header Authorization = 'Bearer eda5ea58ba9befd9d42298a9fb8c405e3c2d7d8d'


#Get all sections
  Scenario: Get all sections
    Given path 'sections'
    * def id = read("file:target/projectId.txt")
    And params { project_id: '#(id)' }
    When method GET
    Then status 200
    Then match response == '#array'

#Create a new section
  Scenario: Create a new section
      Given path 'sections'
      * def projectId = read("file:target/projectId.txt")
      * def requestPayload = { "project_id": "#(projectId)", "name": "Groceries" }
      And request requestPayload
      And header Content-Type = 'application/json'
      When method POST
      Then status 200
      * def sectionId = response.id
      And karate.write(sectionId, 'sectionId.txt')



#Get a single section
  Scenario: Get a single section
    * def id = read("file:target/sectionId.txt")
    Given path '/sections/'+id
    When method GET
    Then status 200
    * def id = read("file:target/projectId.txt")
    Then def expectedResponse =
          """
          {
          		"id": "#ignore",
          		"project_id": '#(id)',
          		"order": "#ignore",
          		"name": "Groceries"
          	}
          """
    Then match response == expectedResponse
    * print response

#Update a section
  Scenario: Update a section
    * def id = read("file:target/sectionId.txt")
    Given path '/sections/'+id
    And  request '{"name":"Supermarket"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200

# Deleting a section
  Scenario: Delete a section
    * def id = read("file:target/sectionId.txt")
    Given path '/sections/'+id
    When method DELETE
    Then status 204



