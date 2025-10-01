*** Settings ***
Documentation     Example test suite demonstrating Robot Framework usage
Resource         ../Resources/common.robot
Resource         ../Resources/variables.robot
Resource         ../Resources/screenshot_library.robot

Suite Setup      Suite Setup
Suite Teardown   Suite Teardown
Test Setup       Test Setup
Test Teardown    Test Teardown

*** Test Cases ***
Example Test Case - Verify Search
    [Documentation]    Example test case that performs a DuckDuckGo search
    [Tags]    smoke    example
    Search For    Robot Framework
    Page Should Contain    Robot Framework

Example Test Case - Basic Arithmetic
    [Documentation]    Example test case demonstrating variable usage and assertions
    [Tags]    example
    ${result}=    Evaluate    2 + 2
    Should Be Equal As Numbers    ${result}    4
    Log    The result is ${result}

Example Test Case - Intentionally Failing
    [Documentation]    This test case is designed to fail to demonstrate screenshot capture
    [Tags]    negative
    [Setup]    Test Setup    url=https://www.example.com
    Page Should Contain    This text definitely won't be on the page