*** Settings ***
Documentation     A simple example test suite demonstrating Robot Framework basics
Library           Collections
Resource          ../resources/common_keywords.robot

*** Variables ***
${MESSAGE}        Hello, Robot Framework!
${NUMBER}         42

*** Test Cases ***
Example Test Case 1 - Simple Assertion
    [Documentation]    Demonstrates basic variable usage and assertions
    [Tags]    example    basic
    Should Be Equal As Strings    ${MESSAGE}    Hello, Robot Framework!
    Should Be Equal As Numbers    ${NUMBER}    42

Example Test Case 2 - Working With Lists
    [Documentation]    Demonstrates working with lists
    [Tags]    example    collections
    @{fruits}=    Create List    apple    banana    orange
    Length Should Be    ${fruits}    3
    List Should Contain Value    ${fruits}    banana

Example Test Case 3 - Using Custom Keywords
    [Documentation]    Demonstrates using custom keywords from resources
    [Tags]    example    keywords
    ${result}=    Calculate Sum    5    10
    Should Be Equal As Numbers    ${result}    15
    Log Greeting    Robot Framework User

Example Test Case 4 - Control Structures
    [Documentation]    Demonstrates FOR loops and IF conditions
    [Tags]    example    control
    FOR    ${i}    IN RANGE    1    4
        Log    Iteration ${i}
    END
    
    ${value}=    Set Variable    10
    IF    ${value} > 5
        Log    Value is greater than 5
    ELSE
        Log    Value is 5 or less
    END
