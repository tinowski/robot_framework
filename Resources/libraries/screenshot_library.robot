*** Settings ***
Documentation    Library for handling test failure screenshots
Library    SeleniumLibrary
Library    OperatingSystem
Resource    ../config/config.robot

*** Keywords ***
Take Screenshot On Failure
    [Arguments]    ${test_name}
    ${timestamp}=    Get Time    epoch
    ${filename}=    Set Variable    ${test_name}_${timestamp}_FAILED.png
    Create Directory    ${SCREENSHOTS_DIR}
    ${status}    ${value}=    Run Keyword And Ignore Error    Capture Page Screenshot    ${SCREENSHOTS_DIR}/${filename}
    Run Keyword If    '${status}' == 'PASS'    Log    Screenshot saved as '${filename}' in Screenshots directory    WARN
    Run Keyword If    '${status}' == 'FAIL'    Log    Failed to capture screenshot: ${value}    WARN
