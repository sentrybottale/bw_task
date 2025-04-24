# User Profile Creation Test Suite

TL;DR
This project contains a Karate test suite for validating user profile creation on a web application. Karate was selected as my automation tool of choice, due to its versatillity and the posibility to write the tests in a human like DSL. Also Karate drives real browsers and can also run in docker container. The tests cover both successful user creation and various validation error scenarios, ensuring the form behaves as expected under different conditions. Test driven approach was taken for the whole excercise, which means that immediately karate was taken as an approach to automate the User Profile form. Overall, the task is really interesting and although easy on the surface, it has a lot of hidden flows - it would have been interesting to make real API calls, and not only JS based validation, so we can completely engage the karate framework API testing functionality and make hybrid tests for web/api. Due to available time constrains, I did not have time to engage multi browser tests, so we are playing only with Chrome on this repo. For the final demonstration, the target folder was removed from .gitignore, and one execution will be commited for proof -> result is in target/karate-reports/karate-summart.html

Use of AI disclaimer: Although the karate setup and use are my althentic approach and work to the task, LLM (Grok3) was used for documentation, test data preparationg and analisys of the .js validations file. This is done to demonstrate how LLMs can speed up the automation process and prevent manual scenario creation, a thing that I will be happy to discuss more during the technical interview.

## Project Overview

The test suite (`adduser_success.feature`) includes scenarios to test the user profile creation form on a web application. The form validates fields such as first name, last name, email, password, confirm password, and LinkedIn URL. The tests verify:

- **Success Case**: A user can be created successfully with valid data, displaying a "Success!" message.
- **Validation Errors**: The form correctly handles invalid inputs, displaying appropriate error messages for:
  - Mismatched passwords
  - Missing LinkedIn URL
  - Empty first name, last name, email, or confirm password
  - Invalid first name or last name (non-alphabetical characters)
  - Invalid email format

### Test Scenarios

- `@success`: Verifies successful user creation with valid data.
- `@passwordMismatch`: Tests the error message when passwords don’t match.
- `@missingLinkedIn`: Tests the error message when the LinkedIn URL is missing.
- `@emptyFirstName`: Tests the error message for an empty first name.
- `@invalidFirstName`: Tests the error message for a first name with non-alphabetical characters.
- `@emptyLastName`: Tests the error message for an empty last name (noting a bug in the validation script where the message incorrectly says "First name must be filled out").
- `@invalidLastName`: Tests the error message for a last name with non-alphabetical characters.
- `@emptyEmail`: Tests the error message for an empty email.
- `@invalidEmail`: Tests the browser’s HTML5 validation message for an invalid email format.
- `@emptyConfirmPassword`: Tests the error message for an empty confirm password.

### Test Data

The test data is stored in `website/util/test_driven_data.csv` and loaded via `website/util/TestData.feature`. Each scenario uses a specific user (U001 to U010) with tailored data to trigger the desired validation case.

## Difficulties Encountered

1. **Page Refresh After Form Submission**:
   - The form automatically refreshes after submission, making it difficult to capture the success message or validation errors. We overcame this by injecting JavaScript to prevent the default form submission behavior (`event.preventDefault()`), allowing us to freeze the page and validate the messages.

2. **Capturing Browser Alerts**:
   - Many validation errors are displayed as JavaScript alerts (`alert()`). Initially, capturing these alerts failed because Karate doesn’t natively handle browser alerts. We resolved this by overriding `window.alert` to store the alert message in `window.alertText`, which we then retrieved and validated.

3. **HTML5 Validation for Email**:
   - The email field uses HTML5 validation (`type="email"`), which displays an inline validation message instead of a JavaScript alert. This caused the `@invalidEmail` scenario to fail initially because we expected an alert. We fixed this by using JavaScript to capture the `validationMessage` property of the email input field and forcing the browser to report the validation message with `reportValidity()`.

4. **Timing Issues**:
   - Validation messages (both alerts and HTML5 messages) sometimes weren’t captured due to timing issues. We added delays (`delay(1000)` or `delay(500)`) after clicking "Submit" to ensure the messages were available before attempting to capture them.

5. **JavaScript Execution Errors**:
   - Early attempts to capture alerts using `script("return window.alertText || ''")` failed with a `SyntaxError: Illegal return statement`. We resolved this by removing the explicit `return` statement, as Karate’s `script` keyword expects an expression that implicitly returns a value.

6. **Bug in Last Name Validation**:
   - The validation script incorrectly displays "First name must be filled out" when the last name is empty. We documented this bug in the `@emptyLastName` scenario and tested the actual behavior, noting that it should be fixed in the application.

## Project Structure

project-root/
├── website/
│   ├── util/
│   │   ├── TestData.feature
│   │   ├── test_driven_data.csv
│   ├── adduser_success.feature
├── karate-config.js
├── karate-1.5.0.jar
├── .gitignore
├── README.md


- `website/adduser_success.feature`: The main test suite with all scenarios.
- `website/util/TestData.feature`: Loads test data from the CSV file.
- `website/util/test_driven_data.csv`: Contains test data for all scenarios (U001 to U010).
- `karate-config.js`: Configures Karate settings, such as the `baseURL` for the web application.
- `karate-1.5.0.jar`: The Karate standalone JAR used to run the tests.
- `.gitignore`: Ignores generated files like the `target/` directory.
- `README.md`: This documentation file.

## Running the Tests

### Prerequisites
- **Java**: You only need Java installed to run the tests. Ensure you have Java 8 or higher installed. You can verify this by running:


### Steps to Run
1. **Clone or Download the Project**:
 - Clone the repository or download the project files to your local machine.

2. **Navigate to the Project Directory**:
 - Open a terminal and navigate to the project root directory (where `karate-1.5.0.jar` is located):
   ```
   cd path/to/project-root
   ```

3. **Run the Tests**:
 - Use the Karate standalone JAR to execute the tests. Run the following command (MacOS/Linux):
   ```
   java -cp karate-1.5.0.jar:. com.intuit.karate.Main website/adduser_success.feature -e=dev;
   ```
 - This command runs all scenarios in `adduser_success.feature`. Karate will automatically use the `karate-config.js` for configuration and load the test data via `TestData.feature`.

4. **View the Results**:
 - After the tests complete, Karate will generate a report in the `target/` directory. Open the HTML report (e.g., `target/karate-reports/karate-summary.html`) in a browser to view the test results.

### Notes
- Ensure the web application is running and accessible at the URL specified in `karate-config.js` (via `baseURL`).

### AI Tools Used
- Grok 3

### Time for doing the task
- About 3 hours

### Notable bugs
- For Last name in the script, it is written First name must be filled out"
- Optional fields are in fact all required
- Multiple alert types are the biggest drawback to make a unified alert handler tests




