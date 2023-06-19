Feature: File Upload

  Background:
    * url 'https://filebin.net'

  Scenario:File Upload Testcase
    Given  path '/'
    And header Content-type = "image/png"
    And request karate.read("file:src/test/java/examples/kkk.png");
    When method POST

  Scenario: File Upload Testcase
    Given path 'https://api.graphql.jobs/'
    Given text query =
    """
    query{
    jobs{
    id,title}
    }
    """
    And request {query: '#(query)'}
    When method POST

  Scenario:Get a singel user
    Given url 'https://reqres.in/api/users/2'
    When method GET
    Then match response == '#object'
    * def jsonSchema =
    """
    {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
    """
    * match response == jsonSchema

  Scenario:Get a single user
      Given url 'https://reqres.in/api/users/2'
      When method GET
      Then match response == '#object'
    * string jsonSchema = read('file: KarateTestMaveen/src/test/java/examples/dataSchema.json');
    * string jsonData = response
    * def SchemaUtils = Java.type('scrolltest.JSONSchemaUtil')
    * assert SchemaUtils.isValid(jsonData,jsonSchema)





