*** Settings ***
Library    SeleniumLibrary
Resource    variables.robot

*** Keywords ***
Take Screenshot On Failure
    [Arguments]    ${test_name}
    Create Directory    ${SCREENSHOTS_DIR}
    Capture Page Screenshot    ${SCREENSHOTS_DIR}/${test_name}_FAILED.png