Feature: This is a basic test (positive scenario), to create a user

Background: 


@success
Scenario: Create a user, freeze the page, and validate success message
    Given driver baseURL
    * def user_id = "U001" 
    * call read('classpath:website/util/TestData.feature')
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


@passwordMismatch
Scenario: Attempt to create a user with mismatched passwords and validate error message
    * def user_id = "U002"
    * call read('classpath:website/util/TestData.feature')
    Given driver baseURL
    # Capture the alert text by overriding window.alert
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
    * script("window.alert = (msg) => window.alertText = msg")
    * waitFor("[value='Submit']").click()
    # Capture and validate the alert message
    * def alertText = script("window.alertText || ''")
    * match alertText == "Passwords do not match"
    * print 'Alert text:', alertText
    * script("window.alertText = '';")


    @missingLinkedIn
Scenario: Attempt to create a user with missing LinkedIn URL and validate error message
    * def user_id = "U003"
    * call read('classpath:website/util/TestData.feature')
    Given driver baseURL
    * script("window.alert = (msg) => window.alertText = msg")
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
    * delay(1000)
    * def alertText = script("window.alertText || ''")
    * match alertText == "LinkedIn must be filled out"
    * script("window.alertText = '';")
    * print 'Alert text:', alertText

@emptyFirstName
Scenario: Attempt to create a user with empty first name and validate error message
    * def user_id = "U004"
    * call read('classpath:website/util/TestData.feature')
    Given driver baseURL
    * script("window.alert = (msg) => window.alertText = msg")
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
    * delay(1000)
    * def alertText = script("window.alertText || ''")
    * match alertText == "First name must be filled out"
    * script("window.alertText = '';")
    * print 'Alert text:', alertText

@invalidFirstName
Scenario: Attempt to create a user with invalid first name and validate error message
    * def user_id = "U005"
    * call read('classpath:website/util/TestData.feature')
    Given driver baseURL
    * script("window.alert = (msg) => window.alertText = msg")
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
    * delay(1000)
    * def alertText = script("window.alertText || ''")
    * match alertText == "First name must contain alphabetical characters only"
    * script("window.alertText = '';")
    * print 'Alert text:', alertText

@emptyLastName
Scenario: Attempt to create a user with empty last name and validate error message
    * def user_id = "U006"
    * call read('classpath:website/util/TestData.feature')
    Given driver baseURL
    * script("window.alert = (msg) => window.alertText = msg")
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
    * delay(1000)
    * def alertText = script("window.alertText || ''")
    # Bug in script; should be "Last name..."
    * match alertText == "First name must be filled out" 
    * script("window.alertText = '';")
    * print 'Alert text:', alertText


@invalidLastName
Scenario: Attempt to create a user with invalid last name and validate error message
    * def user_id = "U007"
    * call read('classpath:website/util/TestData.feature')
    Given driver baseURL
    * script("window.alert = (msg) => window.alertText = msg")
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
    * delay(1000)
    * def alertText = script("window.alertText || ''")
    * match alertText == "Last name must contain alphabetical characters only"
    * script("window.alertText = '';")
    * print 'Alert text:', alertText

@emptyEmail
Scenario: Attempt to create a user with empty email and validate error message
    * def user_id = "U008"
    * call read('classpath:website/util/TestData.feature')
    Given driver baseURL
    * script("window.alert = (msg) => window.alertText = msg")
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
    * delay(1000)
    * def alertText = script("window.alertText || ''")
    * match alertText == "Email must be filled out"
    * script("window.alertText = '';")
    * print 'Alert text:', alertText


@invalidEmail
Scenario: Attempt to create a user with invalid email and validate error message
    * def user_id = "U009"
    * call read('classpath:website/util/TestData.feature')
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
    * delay(1000)
    # Force the browser to report validation message by checking validity
    * script("document.forms['profileForm']['email'].reportValidity()")
    * delay(500)
    # Capture the browser's validation message from the email input
    * def validationMessage = script("document.forms['profileForm']['email'].validationMessage || ''")
    * match validationMessage contains "Please include an '@' in the email address"
    * print 'Validation message:', validationMessage
    * delay(5000)

@emptyConfirmPassword
Scenario: Attempt to create a user with empty confirm password and validate error message
    * def user_id = "U010"
    * call read('classpath:website/util/TestData.feature')
    Given driver baseURL
    * script("window.alert = (msg) => window.alertText = msg")
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
    * delay(1000)
    * def alertText = script("window.alertText || ''")
    * match alertText == "Confirm password must be filled out"
    * print 'Alert text:', alertText
    * script("window.alertText = '';")