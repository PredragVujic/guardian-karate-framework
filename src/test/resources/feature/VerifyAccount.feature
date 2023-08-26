@Regression
Feature: Verify Account 

Background: setup test
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('GenerateToken.feature')
And print result
* def validToken = result.response.token
#Scenario #7
Scenario: Verify and account that is in exist
Given path "api/accounts/get-account"
#with def step create variable and assign value for reusability
* def existingId = 9581
And param primaryPersonId = existingId
#Header have toadd to request
And header Authorization = "Bearer " + validToken
When method get
Then status 200
And print response
And assert response.primaryPerson.id == existingId
#Scenario #8
Scenario: Verify get-account with id not exist 
And path "api/token"
And request {"username":"supervisor", "password":"tek_supervisor"}
When method post
Then status 200
And print response
Given path "api/accounts/get-account"
And header Authorization = "Bearer " + response.token
And param primaryPersonId = "92929229922"
When method get
Then status 404
And print response
And assert response.errorMessage == "Account with id 92929229922 not found"
#Scenario #9
Scenario: 
