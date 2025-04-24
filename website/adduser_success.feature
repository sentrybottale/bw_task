Feature: This is a basic test (postitive scenarion), to create a user

Background: Load test data
    * def user_id = "U001" 
    * callonce read('classpath:website/util/TestData.feature')


@success
Scenario: 
    Given driver baseURL
    * waitFor("[id='firstName']")
    * input("[id='firstName']", userData.firstName)
    * input("[id='lastName']", userData.lastName)
    * input("[id='email']", userData.email)
    * input("[id='password']", userData.password)
    * input("[id='confirmPassword']", userData.confirmPassword)
    * waitFor("[id='male']").click()
    * input("[id='dob']", userData.dob)
    * input("[id='phone']", userData.phone)
    * input("[id='address']", userData.address)
    * input("[id='linkedIn']", userData.linkedIn)
    * input("[id='github']", userData.github)
    * waitFor("[value='Submit']").click()
    * waitFor(".successMessage")
    * match text(".successMessage") == "Success!"
    * delay(5000)
