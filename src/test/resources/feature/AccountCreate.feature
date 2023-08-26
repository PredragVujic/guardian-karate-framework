Feature: Account Creation

Background: 
* def createAccountAndPhone = callonce read('CreateAccount.feature')
* def validToken = createAccountAndPhone.validToken
* def createdAccountId = createAccountAndPhone.response.id
And print createAccountAndPhone
* url "https://tek-insurance-api.azurewebsites.net"

Scenario: Add address, Car and phone number to account
And path "/api/accounts/add-account-address"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
And request
"""
{
  
  "addressType": "Home",
  "addressLine1": "",
  "city": "Belgrade",
  "state": "RS",
  "postalCode": "1100",
  "countryCode": "+38",
  "current": true
}
"""
When method post
Then status 201
And print response
And path "/api/accounts/add-account-car"
* def licenseGenerator = Java.type('api.utility.data.GenerateData')
* def licensePlate = licenseGenerator.getLicensePlate()
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
And request 
"""
{
  
  "make": "Zastava",
  "model": "Yugo",
  "year": "1980",
  "licensePlate": "#(licensePlate)"
}
"""
When method post
And status 201
And print response
Given path "/api/accounts/add-account-phone"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
* def dataGenerator = Java.type('api.utility.data.GenerateData')
* def  phoneNumber = dataGenerator.getPhoneNumber()
And request
"""
{
  
  "phoneNumber": "#(phoneNumber)",
  "phoneExtension": "",
  "phoneTime": "evening",
  "phoneType": "mobile"
}
"""
When method post
Then status 201
And assert response.phoneNumber == phoneNumber
Given path "/api/accounts/delete-account"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
When method delete
Then status 200
And print response
And assert response == "Account Successfully deleted"
