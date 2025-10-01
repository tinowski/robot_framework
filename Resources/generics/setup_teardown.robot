*** Settings ***
Documentation     Production-ready test setup and teardown with comprehensive error handling
Library          SeleniumLibrary
Library          OperatingSystem
Library          DateTime
Resource         ../config/config.robot
Resource         ../page_objects/cookie_consent.robot

*** Keywords ***
Start Test
    [Documentation]    Initializes test environment with proper error handling
    [Arguments]    ${url}=${BASE_URL}    ${browser}=${BROWSER}    ${options}=${CHROME_OPTIONS}
    Create Test Directory Structure
    Initialize Browser Session    ${url}    ${browser}    ${options}
    Set Selenium Timeout    ${TIMEOUT}
    Run Keyword And Ignore Error    Accept Cookies If Present

Create Test Directory Structure
    [Documentation]    Ensures all required directories exist
    FOR    ${dir}    IN    ${SCREENSHOTS_DIR}    ${RESULTS_DIR}
        Create Directory    ${dir}
        Directory Should Exist    ${dir}
    END

Initialize Browser Session
    [Documentation]    Starts browser session with error handling
    [Arguments]    ${url}    ${browser}    ${options}
    ${status}    ${message}=    Run Keyword And Ignore Error
    ...    Open Browser    ${url}    ${browser}    ${options}
    Run Keyword If    '${status}' == 'FAIL'
    ...    Fail    Failed to initialize browser session: ${message}
    Maximize Browser Window
    Log    Browser session initialized: ${browser} at ${url}

End Test
    [Documentation]    Cleans up test environment and captures failures
    [Arguments]    ${name}=${TEST NAME}
    Run Keyword If Test Failed    Capture Test Failure    ${name}
    Close All Browser Sessions

End Suite
    [Documentation]    Performs final cleanup after suite execution
    Close All Browser Sessions

Capture Test Failure
    [Documentation]    Captures comprehensive failure information
    [Arguments]    ${name}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${filename}=    Set Variable    ${name}_${timestamp}_FAILED.png
    ${filepath}=    Set Variable    ${SCREENSHOTS_DIR}/${filename}
    
    # Capture failure evidence
    Run Keyword And Ignore Error    Capture Page Screenshot    ${filepath}
    Run Keyword And Ignore Error    Log Source
    
    # Log failure details
    ${url}=    Get Location
    ${title}=    Get Title
    Log    Failure Details:    WARN
    Log    - Test: ${name}    WARN
    Log    - URL: ${url}    WARN
    Log    - Title: ${title}    WARN
    Log    - Screenshot: ${filename}    WARN

Close All Browser Sessions
    [Documentation]    Safely closes all browser sessions
    ${status}    ${message}=    Run Keyword And Ignore Error    Close All Browsers
    Run Keyword If    '${status}' == 'FAIL'
    ...    Log    Warning: Failed to close browsers: ${message}    WARN