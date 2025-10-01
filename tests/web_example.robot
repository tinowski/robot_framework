*** Settings ***
Documentation     Example web test suite (requires browser setup)
Library           SeleniumLibrary
Resource          ../resources/common_keywords.robot

*** Variables ***
${BROWSER}        Chrome
${DELAY}          0.5s

*** Test Cases ***
Example Web Test - Google Search
    [Documentation]    Example test for web automation using SeleniumLibrary
    ...                NOTE: This test requires a browser driver (chromedriver/geckodriver)
    ...                and will be skipped in environments without browser support
    [Tags]    web    selenium    manual
    Pass Execution    This is an example test - requires browser setup to run

*** Keywords ***
Open Browser To Start Page
    [Documentation]    Opens browser to the configured URL
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
