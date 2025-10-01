*** Settings ***
Library    SeleniumLibrary
Resource    ../config/config.robot

*** Keywords ***
Wait For And Click Element
    [Arguments]    ${locator}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Wait Until Element Is Enabled    ${locator}    ${timeout}
    Click Element    ${locator}

Wait For And Input Text
    [Arguments]    ${locator}    ${text}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Wait Until Element Is Enabled    ${locator}    ${timeout}
    Input Text    ${locator}    ${text}

Wait For Page Load
    [Arguments]    ${timeout}=${DEFAULT_TIMEOUT}
    Wait For Condition    return document.readyState == "complete"    ${timeout}

Retry Keyword Until Success
    [Arguments]    ${keyword}    @{arguments}
    Wait Until Keyword Succeeds    ${MAX_RETRIES}x    ${RETRY_TIMEOUT}    Run Keywords    ${keyword}    @{arguments}

Clear Input Field
    [Arguments]    ${locator}
    Wait For And Click Element    ${locator}
    Press Keys    ${locator}    CTRL+a+DELETE
