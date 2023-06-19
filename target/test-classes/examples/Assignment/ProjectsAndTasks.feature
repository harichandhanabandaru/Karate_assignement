Feature: Todoist API Testing assignment

  Background:
    * url 'https://api.todoist.com/rest/v2'
    * header Authorization = 'Bearer eda5ea58ba9befd9d42298a9fb8c405e3c2d7d8d'
    * def uuid = java.util.UUID.randomUUID().toString()


#Get a user's projects
  Scenario: Get projects
    Given path 'projects'
    When method GET
    Then status 200
    Then match karate.typeOf(response) == 'list'
    And print response

#Adding a new project
  Scenario: Create a project
     Given path 'projects'
     And request { name: 'Shopping List' }
     And header Content-Type = 'application/json'
     When method POST
     Then status 200
     And print response

#    Adding a new task
  Scenario: Add a new task
    Given path 'tasks'
    And request '{"content": "Buy Milk", "project_id": 2314681572}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    Then response.content="Buy Milk"
    And print response
    And match response ==
    """
    {
      "id": "#string",
      "assigner_id": "#null",
      "assignee_id": "#null",
      "project_id": "#string",
      "section_id": "#null",
      "parent_id": "#null",
      "order": "#number",
      "content": "#string",
      "description": "#string",
      "is_completed": "#boolean",
      "labels": "#array",
      "priority": "#number",
      "comment_count": "#number",
      "creator_id": "#string",
      "created_at": "#string",
      "due": "#null",
      "url": "#string",
      "duration": "#null"
    }
    """


#    Updating a task
  Scenario: Updating a task
    Given path 'tasks/6975872152'
    And request '{"content": "Buy Curd"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    Then response.content="Buy Curd"
    And print response

#    Completing a task
   Scenario: Updating a task
     Given path 'tasks/6975872152/close'
     When method POST
     Then status 204


# Deleting a project
  Scenario: Delete a project
     Given path 'projects/2314681382'
     When method DELETE
     Then status 204

#Get all collaborators
  Scenario: Get all collaborators
     Given path '/projects/2314680684/collaborators'
     When method GET
     Then status 200