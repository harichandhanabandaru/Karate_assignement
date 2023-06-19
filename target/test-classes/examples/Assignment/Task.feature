Feature: Todoist API Testing assignment

  Background:
    * url 'https://api.todoist.com/rest/v2'
    * header Authorization = 'Bearer eda5ea58ba9befd9d42298a9fb8c405e3c2d7d8d'
    * def uuid = java.util.UUID.randomUUID().toString()


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
        	"project_id": "2314680664",
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
        		"date": "2023-06-20",
        		"string": "tomorrow at 12:00",
        		"lang": "en",
        		"is_recurring": false,
        		"datetime": "2023-06-20T12:00:00"
        	},
        	"url": "#ignore",
        	"duration": null
        }
        """
    Then match response == expectedResponse
    * print response


#Get an active task
  Scenario: Get an active tasks
    Given path '/tasks/6971355157'
    When method GET
    Then status 200
    Then def expectedResponse =
          """
          {
          	"id": "6971355157",
          	"assigner_id": null,
          	"assignee_id": null,
          	"project_id": "2314680684",
          	"section_id": null,
          	"parent_id": null,
          	"order": 1,
          	"content": "Add all my **work** tasks",
          	"description": "",
          	"is_completed": false,
          	"labels": [],
          	"priority": 3,
          	"comment_count": 0,
          	"creator_id": "44619013",
          	"created_at": "2023-06-16T11:55:02.939710Z",
          	"due": {
          		"date": "2023-06-16",
          		"string": "16 Jun",
          		"lang": "en",
          		"is_recurring": false
          	},
          	"url": "https://todoist.com/showTask?id=6971355157",
          	"duration": null
          }
          """
    Then match response == expectedResponse
    * print response

#Update a task
  Scenario: Update a task
    Given path '/tasks/6975885638'
    And  request '{"content": "Buy Coffee"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200

#Close a task
  Scenario: Close a task
    Given path 'tasks/6975889651/close'
    When method POST
    Then status 204

#ReOpen a task
  Scenario: Reopen a task
    Given path 'tasks/6975889651/reopen'
    When method POST
    Then status 204

# Delete a task
  Scenario: Delete a task
    Given path 'tasks/6976974366'
    When method DELETE
    Then status 204




