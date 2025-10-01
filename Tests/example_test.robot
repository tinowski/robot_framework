*** Settings ***
Documentation     Example test suite demonstrating Robot Framework usage
Resource         ../Resources/common.robot
Resource         ../Resources/variables.robot
Resource         ../Resources/screenshot_library.robot

Test Timeout      1 minute
Test Teardown    Run Keyword If Test Failed    Take Screenshot On Failure    ${TEST_NAME}

*** Variables ***
${MAX_RETRIES}    1

*** Test Cases ***
Example Test Case - Verify Search
    [Documentation]    Example test case that performs a DuckDuckGo search
    [Tags]    smoke    example
    Open Browser To Search
    Search For    Robot Framework
    Page Should Contain    Robot Framework
    [Teardown]    Close Browser

Example Test Case - Basic Arithmetic
    [Documentation]    Example test case demonstrating variable usage and assertions
    [Tags]    example
    ${result}=    Evaluate    2 + 2
    Should Be Equal As Numbers    ${result}    4
    Log    The result is ${result}

Example Test Case - Intentionally Failing
    [Documentation]    This test case is designed to fail to demonstrate screenshot capture and retry mechanism
    [Tags]    negative
    [Setup]    Set Test Variable    ${RETRY_COUNT}    0
    Open Browser    https://www.example.com    ${BROWSER}
    Run Keyword And Expect Error    *    Page Should Contain    This text definitely won't be on the page
    [Teardown]    Run Keywords
    ...    Take Screenshot On Failure    ${TEST NAME}    AND
    ...    Close Browser

*** Keywords ***
Run Failing Test
    ${new_count}=    Evaluate    ${RETRY_COUNT} + 1
    Set Test Variable    ${RETRY_COUNT}    ${new_count}
    Log    Attempt number ${RETRY_COUNT} of ${MAX_RETRIES}    console=yes
    Open Browser    https://www.example.com    ${BROWSER}
    Page Should Contain    This text definitely won't be on the page
    [Teardown]    Run Keyword And Ignore Error    Close Browser
