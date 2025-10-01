*** Settings ***
Documentation     Example test suite demonstrating Robot Framework usage
Resource         ../Resources/common.robot
Resource         ../Resources/variables.robot

*** Test Cases ***
Example Test Case - Verify Google Search
    [Documentation]    Example test case that performs a Google search
    [Tags]    smoke    example
    Open Browser To Google
    Search For    Robot Framework
    Page Should Contain    Robot Framework
    [Teardown]    Close Browser

Example Test Case - Basic Arithmetic
    [Documentation]    Example test case demonstrating variable usage and assertions
    [Tags]    example
    ${result}=    Evaluate    2 + 2
    Should Be Equal As Numbers    ${result}    4
    Log    The result is ${result}
