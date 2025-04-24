Feature: This is a basic test (postitive scenarion), to create a user

Background: Load test data
    * def user_id = "U001" 
    * callonce read('classpath:website/util/TestData.feature')


@success
Scenario: 
    Given driver baseURL
    * waitFor("[id='firstName']")
    * input("[id='firstName']", userData.firstName)
    * delay(5000)
