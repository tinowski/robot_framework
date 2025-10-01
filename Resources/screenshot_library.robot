*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
Take Screenshot On Failure
    [Arguments]    ${test_name}
    ${timestamp}=    Get Time    epoch
    ${filename}=    Set Variable    ${test_name}_${timestamp}_FAILED.png
    Set Screenshot Directory    /Users/tino/Desktop/ROBOT_TESTING/robot_framework/Screenshots
    ${status}    ${value}=    Run Keyword And Ignore Error    Capture Page Screenshot    ${filename}
    Run Keyword If    '${status}' == 'FAIL'    Log    Failed to capture screenshot: ${value}    WARN
    Run Keyword If    '${status}' == 'PASS'    Log    Screenshot saved as '${filename}' in Screenshots directory    WARN