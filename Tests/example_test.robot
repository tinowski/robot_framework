*** Settings ***
Documentation     Production test suite demonstrating key features and best practices
Resource         ../Resources/generics/setup_teardown.robot
Resource         ../Resources/page_objects/search_page.robot

Suite Setup      Start Test
Suite Teardown   End Suite
Test Setup       Start Test
Test Teardown    End Test

Force Tags      regression    production

*** Test Cases ***
Verify Search Functionality
    [Documentation]    Validates core search functionality
    [Tags]    smoke    search    critical
    [Timeout]    1 minute
    Search For    Robot Framework

Verify Basic Calculations
    [Documentation]    Validates basic calculation functionality
    [Tags]    unit    calculator
    [Timeout]    30 seconds
    ${result}=    Evaluate    2 + 2
    Should Be Equal As Numbers    ${result}    4
    Log    Calculation verified: 2 + 2 = ${result}

Verify Error Handling
    [Documentation]    Demonstrates error handling and screenshot capture
    [Tags]    negative    error-handling
    [Timeout]    30 seconds
    [Setup]    Start Test    https://example.com
    Run Keyword And Expect Error    *    Page Should Contain    This text does not exist
    Log    Error handling verified successfully    WARN

Verify Search Results Validation
    [Documentation]    Demonstrates failing test with screenshot capture
    [Tags]    negative    search    validation
    [Timeout]    30 seconds
    Search For    Robot Framework
    # This should fail and trigger screenshot capture
    Page Should Contain    This text definitely does not exist in search results