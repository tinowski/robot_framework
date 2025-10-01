*** Settings ***
Library    SeleniumLibrary
Resource    variables.robot

*** Keywords ***
Open Browser To Google
    Open Browser    ${GOOGLE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Google Page Should Be Open

Google Page Should Be Open
    Title Should Be    Google

Search For
    [Arguments]    ${search_term}
    Input Text    ${SEARCH_INPUT}    ${search_term}
    Press Keys    ${SEARCH_INPUT}    RETURN
    Wait Until Page Contains    ${search_term}
