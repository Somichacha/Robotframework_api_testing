*** Settings ***
Documentation   Automate Api responses  for pet store
Library  RequestsLibrary
Library  JSONLibrary
Library  BuiltIn
Library  Collections

*** Test Cases ***
Get pet by status
  [Documentation]  This test case retrieves pets by their status from the Petstore API.
    Create Session  My Session   https://petstore.swagger.io/v2
    ${response}=  GET On Session  My Session   /pet/findByStatus?  params=status=available
   Status Should Be   200  ${response}

Get pet with status pending
  [Documentation]  This test case retrieves pets with status 'pending' from the Petstore API.
    Create Session  My Session   https://petstore.swagger.io/v2
    ${response}=  GET On Session  My Session   /pet/findByStatus?  params=status=pending
    Status Should Be   200  ${response}

Get pet with status sold
  [Documentation]  This test case retrieves pets with status 'sold' from the Petstore API.
    Create Session  My Session   https://petstore.swagger.io/v2
    ${response}=  GET On Session  My Session   /pet/findByStatus?  params=status=sold
    Status Should Be   200  ${response}

Create a pet
  [Documentation]  This test creates a new pet in the petstore API.
  Create Session    My Session     https://petstore.swagger.io/v2
  ${Body}=  Create Dictionary  id=0  name=Buddy  status=available
  ${response}=  POST    https://petstore.swagger.io/v2/pet  json=${Body}
    Status Should Be   200  ${response}

Update a pet in petstore
  [Documentation]  This test updates an existing pet in petstore API.
  Create Session    My Session     https://petstore.swagger.io/v2
    ${Body}=  Create Dictionary  id=9223372016900032458  name=Dog  status=available
    ${response}=  PUT    https://petstore.swagger.io/v2/pet  json=${Body}
    Log To Console   ${response}
    Status Should Be   200  ${response}

Delete a pet in petstore
  [Documentation]  This test deletes a pet in petstore API.
  ${response}=  DELETE    https://petstore.swagger.io/v2/pet/9223372016900032458
   Log To Console   ${response}
   Status Should Be   200  ${response}

Place an order for a pet
  [Documentation]  This test places an order for a pet in the petstore API.
  Create Session    My Session     https://petstore.swagger.io/v2
  ${Body}=  Create Dictionary  id=0  petId=9223372016900032458  quantity=1  shipDate=2026-09-29T10:46:12.219Z  status=placed  complete=true
  ${response}=  POST    https://petstore.swagger.io/v2/store/order  json=${Body}
   Log To Console   ${response}
   Status Should Be   200  ${response}


Create list of users with given input
  [Documentation]  This test creates a list of users in the petstore API.
  Create Session    My Session     https://petstore.swagger.io/v2
  ${user}=  Create Dictionary
    ...    id=0
    ...    username=User1
    ...    firstName=John
    ...    lastName=Doe
    ...    email=user1@example.com
    ...    password=Password123
    ...    phone=0987654321
    ...    userStatus=0
   ${Body}=    Create List    ${user}
  ${response}=  POST    https://petstore.swagger.io/v2/user/createWithList  json=${Body}
   Log To Console   ${response}
   Status Should Be   200  ${response}
