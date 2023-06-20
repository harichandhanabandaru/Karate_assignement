Feature: Todoist API Testing assignment for projects section

  Background:
    * url 'https://api.todoist.com/rest/v2'
    * header Authorization = 'Bearer eda5ea58ba9befd9d42298a9fb8c405e3c2d7d8d'

# Adding a new project
  Scenario: Create a project
    Given path 'projects'
    And request { name: 'Shopping List' }
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    And print response
    * def projectId = response.id
    And karate.write(projectId,'projectId.txt')

# Get a user's projects
  Scenario: Get projects
    * def id = read("file:target/projectId.txt")
    Given path 'projects/'+id
    When method GET
    Then status 200
    And print response


#    Add a new task
  Scenario: Add a new task
    Given path 'tasks'
    * def id = read("file:target/projectId.txt")
    And request { "content": "Buy Milk", "project_id": '#(id)' }
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    Then response.content = "Buy Milk"
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
    * def taskId = response.id
    And karate.write(taskId,'taskId.txt')


#    Updating a task
  Scenario: Updating a task
    * def id = read("file:target/taskId.txt")
    Given path 'tasks/'+id
    And request '{"content": "Buy Curd"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    Then response.content="Buy Curd"
    And print response

#    Completing a task
  Scenario: Close a task
    * def id = read("file:target/taskId.txt")
    Given path 'tasks/'+id+'/close'
    When method POST
    Then status 204


# Get all collaborators
  Scenario: Get all collaborators
    * def id = read("file:target/projectId.txt")
    Given path '/projects/'+id+'/collaborators'
    When method GET
    Then status 200

# Deleting a project
  Scenario: Delete a project
    * def id = read("file:target/projectId.txt")
    Given path 'projects/'+id
    When method DELETE
    Then status 204

