*** Settings ***
Resource    variables.robot
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
Test Setup
    [Arguments]    ${browser}=${BROWSER}    ${url}=${SEARCH_URL}    ${options}=${CHROME_OPTIONS}
    Set Selenium Speed    ${DELAY}
    Create Directory    ${SCREENSHOTS_DIR}
    Open Browser    ${url}    ${browser}    ${options}
    Maximize Browser Window
    Run Keyword And Ignore Error    Handle Cookie Consent

Test Teardown
    [Arguments]    ${screenshot_name}=${TEST NAME}
    Run Keyword If Test Failed    Take Screenshot On Failure    ${screenshot_name}
    Close All Browsers

Suite Setup
    Create Directory    ${SCREENSHOTS_DIR}
    Set Screenshot Directory    ${SCREENSHOTS_DIR}

Suite Teardown
    Close All Browsers

Open Browser To Search
    Open Browser    ${SEARCH_URL}    ${BROWSER}    ${CHROME_OPTIONS}
    Set Selenium Speed    ${DELAY}
    Handle Cookie Consent
    Search Page Should Be Open

Handle Cookie Consent
    # List of common cookie iframe patterns
    @{iframe_patterns}=    Create List
    ...    //iframe[contains(@id, 'cookie')]
    ...    //iframe[contains(@title, 'cookie')]
    ...    //iframe[contains(@id, 'consent')]
    ...    //iframe[contains(@class, 'consent-frame')]
    
    # List of common accept button patterns
    @{button_patterns}=    Create List
    ...    //button[contains(text(), 'Accept')]
    ...    //button[contains(text(), 'Accept all')]
    ...    //button[contains(text(), 'Allow')]
    ...    //button[contains(text(), 'Agree')]
    ...    //button[contains(@aria-label, 'accept')]
    ...    //*[contains(@class, 'accept')]//button[last()]
    ...    //*[contains(@class, 'consent')]//button[last()]
    
    # Try each iframe pattern
    FOR    ${iframe}    IN    @{iframe_patterns}
        ${iframe_present}=    Run Keyword And Return Status    Page Should Contain Element    ${iframe}
        Run Keyword If    ${iframe_present}    Run Keywords
        ...    Select Frame    ${iframe}    AND
        ...    Try Cookie Buttons    ${button_patterns}    AND
        ...    Unselect Frame
        Exit For Loop If    ${iframe_present}
    END
    
    # If no iframe found, try buttons directly on page
    Try Cookie Buttons    ${button_patterns}
    
    # Final attempt using JavaScript if all else fails
    ${js_status}=    Run Keyword And Return Status    Execute JavaScript
    ...    Array.from(document.querySelectorAll('button,input[type="button"],a.button')).find(el => 
    ...        el.textContent.toLowerCase().includes('accept') || 
    ...        el.textContent.toLowerCase().includes('agree') || 
    ...        el.textContent.toLowerCase().includes('allow'))?.click()

Try Cookie Buttons
    [Arguments]    ${button_patterns}
    FOR    ${pattern}    IN    @{button_patterns}
        ${button_present}=    Run Keyword And Return Status    Page Should Contain Element    ${pattern}
        Run Keyword If    ${button_present}    Run Keywords
        ...    Wait Until Element Is Visible    ${pattern}    timeout=2s    AND
        ...    Click Element    ${pattern}
        Exit For Loop If    ${button_present}
    END

Search Page Should Be Open
    Wait Until Element Is Visible    ${SEARCH_INPUT}
    Element Should Be Enabled    ${SEARCH_INPUT}

Search For
    [Arguments]    ${search_term}
    # Wait for search input to be ready
    Wait Until Element Is Visible    ${SEARCH_INPUT}    timeout=10s
    Wait Until Element Is Enabled    ${SEARCH_INPUT}    timeout=10s
    
    # Clear any existing text
    Press Keys    ${SEARCH_INPUT}    CTRL+a+DELETE
    
    # Input the search term
    Input Text    ${SEARCH_INPUT}    ${search_term}
    Sleep    1s
    
    # Try clicking the search button first
    ${button_visible}=    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    ${SEARCH_BUTTON}    timeout=2s
    Run Keyword If    ${button_visible}    Click Element    ${SEARCH_BUTTON}
    
    # If button not visible or click fails, use RETURN key
    IF    not ${button_visible}    Press Keys    ${SEARCH_INPUT}    RETURN
    
    # Wait for results with multiple verification attempts
    Wait Until Keyword Succeeds    15s    1s    Verify Search Results    ${search_term}

Verify Search Results
    [Arguments]    ${search_term}
    # Check multiple indicators that search is complete
    Page Should Contain    ${search_term}
    ${url}=    Get Location
    Should Contain    ${url}    q=    # DuckDuckGo uses 'q' parameter for searches