*** Settings ***
Documentation     Common keywords and variables used across test suites

*** Variables ***
${DEFAULT_TIMEOUT}    10s
${BASE_URL}           http://localhost:8080

*** Keywords ***
Calculate Sum
    [Documentation]    Calculates the sum of two numbers
    [Arguments]    ${number1}    ${number2}
    ${result}=    Evaluate    ${number1} + ${number2}
    RETURN    ${result}

Log Greeting
    [Documentation]    Logs a personalized greeting message
    [Arguments]    ${name}
    Log    Hello, ${name}! Welcome to Robot Framework.
    Log    This is a custom keyword from resources.

Setup Test Environment
    [Documentation]    Common setup actions for tests
    Log    Setting up test environment
    Set Log Level    INFO

Teardown Test Environment
    [Documentation]    Common teardown actions for tests
    Log    Cleaning up test environment
