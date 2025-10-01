*** Settings ***
Documentation    Cookie consent handling
Resource    base_page.robot

*** Variables ***
${ACCEPT_BUTTON}    xpath=//button[contains(@class, 'consent') or contains(text(), 'Accept')]

*** Keywords ***
Accept Cookies If Present
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${ACCEPT_BUTTON}
    Run Keyword If    ${visible}    Click Element When Ready    ${ACCEPT_BUTTON}