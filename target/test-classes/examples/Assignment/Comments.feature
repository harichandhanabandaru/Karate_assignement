Feature: Todoist API Testing assignment

  Background:
    * url 'https://api.todoist.com/rest/v2'
    * header Authorization = 'Bearer eda5ea58ba9befd9d42298a9fb8c405e3c2d7d8d'
    * def uuid = java.util.UUID.randomUUID().toString()


#Get all comments
  Scenario: Get all comments
    Given path 'comments'
    And params { task_id: '6971355157' }
    When method GET
    Then status 200


#Create a new comment
  Scenario: Create a new comment
    Given path 'comments'
    And request
    """
    {
        "task_id": 6971355157,
        "content": "Need one bottle of milk",
        "attachment": {
            "resource_type": "file",
            "file_url": "https://s3.amazonaws.com/domorebetter/Todoist+Setup+Guide.pdf",
            "file_type": "application/pdf",
            "file_name": "File.pdf"
        }
    }
    """
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    Then def expectedResponse =
        """
        {
        	"id": "#ignore",
        	"task_id": "6971355157",
        	"project_id": null,
        	"content": "Need one bottle of milk",
        	"posted_at": "#ignore",
        	"attachment": {
        		"file_name": "File.pdf",
        		"file_type": "application/pdf",
        		"file_url": "https://s3.amazonaws.com/domorebetter/Todoist+Setup+Guide.pdf"
        	}
        }
        """
    Then match response == expectedResponse
    * print response


#Get a comment
  Scenario: Get an comment
    Given path '/comments/3298577027'
    When method GET
    Then status 200
    Then def expectedResponse =
          """
{
	"id": "3298577027",
	"task_id": "6971355157",
	"project_id": null,
	"content": "Need one bottle of milk",
	"posted_at": "2023-06-19T04:06:59.707365Z",
	"attachment": {
		"file_name": "File.pdf",
		"file_type": "application/pdf",
		"file_url": "https://s3.amazonaws.com/domorebetter/Todoist+Setup+Guide.pdf"
	}
}

          """
    Then match response == expectedResponse
    * print response

#Update a comment
  Scenario: Update a task
    Given path '/comments/3298577027'
    And  request '{"content": "Need two bottles of milk"}'
    And header Content-Type = 'application/json'
    When method POST
    Then status 200



# Delete a comment
  Scenario: Delete a comment
    Given path '/comments/3298577141'
    When method DELETE
    Then status 204




