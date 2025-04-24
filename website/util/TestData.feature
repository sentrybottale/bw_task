Feature: Load Once the User Test Data

Background: 
    * def testUsers = read('classpath:website/util/test_driven_data.csv')
    * def userData = testUsers.find(x => x['user_id'] === user_id)

Scenario:
