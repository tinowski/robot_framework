*** Settings ***
Documentation     Production-ready DuckDuckGo search page implementation
Resource         base_page.robot

*** Variables ***
${SEARCH_INPUT}     id=searchbox_input    # Main search input field
${SEARCH_BUTTON}    xpath=//button[@type='submit']    # Search submit button

*** Keywords ***
Search For
    [Documentation]    Performs search with validation and error handling
    [Arguments]    ${term}
    [Timeout]    ${TIMEOUT}
    Input Search Term    ${term}
    Submit Search
    Verify Search Results    ${term}

Input Search Term
    [Documentation]    Inputs search term with validation
    [Arguments]    ${term}
    Log    Inputting search term: ${term}
    Input Text When Ready    ${SEARCH_INPUT}    ${term}
    ${actual_term}=    Get Element Attribute    ${SEARCH_INPUT}    value
    Should Be Equal    ${actual_term}    ${term}    Search term validation failed

Submit Search
    [Documentation]    Submits search with fallback methods
    ${button_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${SEARCH_BUTTON}
    Run Keyword If    ${button_visible}    Click Element When Ready    ${SEARCH_BUTTON}
    ...    ELSE    Press Keys    ${SEARCH_INPUT}    RETURN
    Log    Search submitted successfully

Verify Search Results
    [Documentation]    Verifies search results with comprehensive checks
    [Arguments]    ${expected_term}
    Wait For Text    ${expected_term}
    ${url}=    Get Location
    ${encoded_term}=    Set Variable    ${expected_term.replace(' ', '+')}
    Should Contain    ${url}    q=${encoded_term}    URL should contain search term
    Page Should Not Contain    No results found    Search should return results
    Log    Search results verified for term: ${expected_term}