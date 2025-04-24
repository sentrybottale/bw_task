Feature: This is a basic test (positive scenario), to create a user

Background: Load test data
    * def user_id = "U001" 
    * callonce read('classpath:website/util/TestData.feature')

@success
Scenario: Create a user, freeze the page, and validate success message
    Given driver baseURL
    # One-liner to prevent form submission refresh and call validateForm
    * script("document.forms['profileForm'].onsubmit = (e) => { e.preventDefault(); validateForm(); }")
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
    # Validate the success message with the correct class name
    * waitFor(".success")
    * match text(".success") == "Success!"
    * delay(5000)