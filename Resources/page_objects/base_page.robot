*** Settings ***
Documentation     Production-ready base page with error handling and logging
Library          SeleniumLibrary
Library          OperatingSystem
Resource         ../config/config.robot

*** Keywords ***
Wait For Element
    [Documentation]    Waits for element to be visible and enabled with proper error handling
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Log    Waiting for element: ${locator}
    Wait Until Keyword Succeeds    ${timeout}    1s    Element Should Be Ready    ${locator}

Element Should Be Ready
    [Documentation]    Verifies element is both visible and enabled
    [Arguments]    ${locator}
    Element Should Be Visible    ${locator}
    Element Should Be Enabled    ${locator}

Click Element When Ready
    [Documentation]    Safely clicks element with validation and error handling
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Wait For Element    ${locator}    ${timeout}
    ${is_clickable}=    Run Keyword And Return Status    Element Should Be Ready    ${locator}
    Run Keyword If    not ${is_clickable}    Fail    Element ${locator} is not clickable
    Run Keyword And Continue On Failure    Scroll Element Into View    ${locator}
    Click Element    ${locator}
    Log    Clicked element: ${locator}

Input Text When Ready
    [Documentation]    Safely inputs text with validation and error handling
    [Arguments]    ${locator}    ${text}    ${timeout}=${TIMEOUT}
    Wait For Element    ${locator}    ${timeout}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}
    ${actual_text}=    Get Element Attribute    ${locator}    value
    Should Be Equal    ${actual_text}    ${text}    Input validation failed
    Log    Input text "${text}" into element: ${locator}

Wait For Text
    [Documentation]    Waits for text to appear with proper error handling
    [Arguments]    ${text}    ${timeout}=${TIMEOUT}
    Log    Waiting for text: ${text}
    Wait Until Keyword Succeeds    ${timeout}    1s    Page Should Contain    ${text}

Verify Page URL
    [Documentation]    Verifies current page URL with proper error handling
    [Arguments]    ${expected_url}
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    ${expected_url}
    Log    Verified URL: ${current_url}