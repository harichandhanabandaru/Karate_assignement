Feature: Todoist API Testing assignment for tasks section

  Background:
    * url 'https://api.todoist.com/rest/v2'
    * header Authorization = 'Bearer eda5ea58ba9befd9d42298a9fb8c405e3c2d7d8d'


#Get all tasks
  Scenario: Get all tasks
    Given path 'tasks'
    When method GET
    Then status 200


#Create a new task
  Scenario: Create a new task
    Given path 'tasks'
    And request '{"content": "Buy Milk", "due_string": "tomorrow at 12:00", "due_lang": "en", "priority": 4}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    Then def expectedResponse =
        """
        {
        	"id": "#ignore",
        	"assigner_id": null,
        	"assignee_id": null,
        	"project_id": "#ignore",
        	"section_id": null,
        	"parent_id": null,
        	"order": "#ignore",
        	"content": "Buy Milk",
        	"description": "",
        	"is_completed": false,
        	"labels": [],
        	"priority": 4,
        	"comment_count": 0,
        	"creator_id": "44619013",
        	"created_at": "#ignore",
        	"due": {
        		"date": "#ignore",
        		"string": "tomorrow at 12:00",
        		"lang": "en",
        		"is_recurring": false,
        		"datetime": "#ignore"
        	},
        	"url": "#ignore",
        	"duration": null
        }
        """
    Then match response == expectedResponse
    * def taskId = response.id
    And karate.write(taskId, 'taskId.txt')
    * print response


#Get an active task
  Scenario: Get an active tasks
    * def id = read("file:target/taskId.txt")
    Given path '/tasks/'+id
    When method GET
    Then status 200
    Then match response.id == '#(id)'
    * print response

#Update a task
  Scenario: Update a task
    * def id = read("file:target/taskId.txt")
    Given path '/tasks/'+id
    And  request '{"content": "Buy Coffee"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200

#Close a task
  Scenario: Close a task
    * def id = read("file:target/taskId.txt")
    Given path 'tasks/'+id+'/close'
    When method POST
    Then status 204

#ReOpen a task
  Scenario: Reopen a task
    * def id = read("file:target/taskId.txt")
    Given path 'tasks/'+id+'/reopen'
    When method POST
    Then status 204

# Delete a task
  Scenario: Delete a task
    * def id = read("file:target/taskId.txt")
    Given path 'tasks/'+id
    When method DELETE
    Then status 204




